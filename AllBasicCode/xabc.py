"""
Extract "All Basic Code" .ABC and .CDE packets
Rob Hagemans 2018. Expat MIT Licence
"""
import struct
import sys
import os
import io
import zipfile

#TODO: multipage PostIt files;  post-it checksum; recognise more post-it files


def decode_postit(lines, fname, depth=0):
    #SUB U(A$):FOR A=1TO LEN(A$):C=ASC(MID$(A$,A))-37:IF C<0THEN C=91+C*32
    #IF K<4THEN K=C+243ELSE?#1,CHR$(C+(K MOD 3)*86);:K=K\3:B&=B&+1
    #S=(S+C)AND 255:NEXT:LOCATE,1:?STRING$(B&*50\22193,219);:END SUB
    #'>>> Page 1 of DATAWHIZ.ZIP begins here. TYPE:BINAA TLEN:22193
    #if not lines[0].startswith(b"'>>> Page 1 of "):
    #    raise ValueError('Input not PostIt encoded')
    print('  ' * depth, fname, '- extracting post-it ... ')
    depth += 1
    length, checksum = 0, 0
    name = b'--none--'
    for line in lines:
        try:
            name = line.split(b'SUB V1:OPEN "O",1,"')[1].split(b'"')[0]
        except IndexError:
            continue
        else:
            if b'Z&=' in line:
                length = int(line.split(b'Z&=')[1].split(b':')[0])
            break
    #if length is None:
    for line in lines:
        if line.lstrip().startswith(b'CLOSE'):
            checksum = int(line.split(b'S=')[1].split(b'AND')[0])
            if not length:
                length = int(line.split(b'B&=')[1].split(b'THEN')[0])
            break
    else:
        print(b'\n'.join(lines).decode('latin1'))
    #name = lines[0][15:].split(b' ')[0]
    #length = int(lines[0].split(b'TLEN:')[1])
    k = 0
    s = 0
    b = 0
    out = bytearray()
    for line in lines:
        if not line.startswith(b'U"'):
            continue
        for a in line[2:]:
            c = a - 37
            if c < 0:
                c = 91 + c*32
            if k < 4:
                k = c + 243
            else:
                try:
                    out.append(c + (k%3)*86)
                except ValueError:
                    print('post-it extraction failed')
                    break
                k = k // 3
                b += 1
            s = (s+c) & 255
    print('  ' * depth, name.decode('ascii'), end='')
    if b != length:
        print('bytecount %+d' % (b - length,), end='')
    if s != checksum:
        print('checksum failed', end='')
    print()
    if name.lower().endswith(b'.zip'):
        f = io.BytesIO(out)
        unpack_zip(f, name.decode('ascii'), depth=depth)
    else:
        while os.path.isfile(name):
            name += b'.1'
            #raise EnvironmentError('Would overwrite existing file:', name)
        with open(name, 'wb') as outfile:
            outfile.write(bytes(out))



def unpack_abc(infile, name, depth=0):
    #     ' Here is the release of the ABC Packet structures
    #
    # TYPE ABCFileStructure         ' Structures for *.ABC
    #   From AS STRING * 31         ' Programmer/Author's name
    #   Subject AS STRING * 31      ' Subject/Title of code
    #   Origin AS STRING * 31       ' Origin of code, or keywords
    #   DateOf AS STRING * 23       ' Date of code release
    #   CodeOf AS STRING * 23       ' Code of (QB,QBasic,PDS,ASIC,PB,VB,ASM,TEXT)
    #   NumLines AS STRING * 5      ' Number of lines in code
    #   NumBytes AS STRING * 9      ' Number of bytes when extracted
    #   SaveFile AS STRING * 12     ' Default extraction name
    # END TYPE
    print('  ' * depth, name, '- extracting ABC ...')
    depth += 1
    name = name.split('.')[0]
    csvfile = name + '.tsv'
    lines = infile.read().split(b'\xe3')
    cwd = os.getcwd()
    os.mkdir(name)
    os.chdir(name)
    with open(csvfile, 'wb') as csv:
        csv.write(b'Author\tTitle\tOrigin/Keywords\tDate\tType\tLines\tBytes\tFilename\n')
        while len(lines) > 1:
            header, lines[0] = lines[0][:165], lines[0][165:]
            record = struct.unpack('<31s31s31s23s23s5s9s12s', header)
            record = tuple(_x.strip(b' \0') for _x in record)
            author, subject, origin, date_of, code_of, numlines, numbytes, savefile = record
            numlines = int(numlines)
            numbytes = int(numbytes)
            csv.write(b'\t'.join(record) + b'\n')
            if len([_l for _l in lines[:numlines] if _l.startswith(b'U"')]) > len([_l for _l in lines[:numlines] if not _l.startswith(b'U"')]):
                # if most lines starting with U", we think it's a post-it
                decode_postit(lines[:numlines], savefile.decode('ascii'), depth=depth)
            else:
                bytestr = b'\r\n'.join(lines[:numlines]) + b'\r\n'
                # rename, don't overwrite
                while os.path.isfile(savefile):
                    savefile += b'.1'
                with open(savefile.strip(), 'wb') as outfile:
                    outfile.write(bytestr)
                if len(bytestr) == numbytes or len(bytestr) == numbytes+2:
                    print('  ' * depth, savefile.decode('ascii'))
                else:
                    print('  ' * depth, savefile.decode('ascii'), 'bytecount %+d' % (len(bytestr) - numbytes))
            lines = lines[numlines:]

            while len(lines) > 1:
                try:
                    header, rest = lines[0][:165], lines[0][165:]
                    record = struct.unpack('<31s31s31s23s23s5s9s12s', header)
                    record = tuple(_x.strip(b' \0') for _x in record)
                    author, subject, origin, date_of, code_of, numlines, numbytes, savefile = record
                    numlines = int(numlines)
                    numbytes = int(numbytes)
                except (ValueError, struct.error):
                    print('  ' * depth, 'WARNING: extra line', lines[0])
                    with open(savefile.strip(), 'ab') as outfile:
                        outfile.write(lines[0] + b'\r\n')
                    lines = lines[1:]
                else:
                    break
    os.chdir(cwd)

def unpack_zipped_abc(filename, depth=0):
    print('  ' * depth, filename, '- extracting ZIP ...')
    name = os.path.basename(filename).split('.')[0]
    with zipfile.ZipFile(filename, 'r') as archive:
        abcs = [_m for _m in archive.namelist() if _m.lower().endswith('.abc') or _m.lower().endswith('.cde')]
        if len(abcs) > 1:
            while os.path.isdir(name):
                name += '.1'
            path = name
        else:
            path = ''
        cwd = os.getcwd()
        if path:
            os.mkdir(path)
            os.chdir(path)
        for abc in abcs:
            with archive.open(abc, 'r') as f:
                unpack_abc(f, abc, depth=depth+1)
        if path:
            os.chdir(cwd)

def unpack_zip(file, name, depth=0):
    dirname = name.split('.')[0]
    try:
        with zipfile.ZipFile(file, 'r') as archive:
            print('  ' * depth, name, '- extracting ZIP ...')
            mems = archive.namelist()
            if len(mems) > 1:
                while os.path.isdir(dirname):
                    dirname += '.1'
                path = dirname
            else:
                path = ''
            for member in mems:
                print('  ' * (depth+1), member)
                archive.extract(member, path)
    except (zipfile.BadZipFile, NotImplementedError):
        # can't extract, just store
        print('  ' * depth, name, "(can't extract)")
        if os.path.isfile(name):
            raise EnvironmentError('Would overwrite existing file:', name)
        with open(name, 'wb') as outfile:
            outfile.write(file.read())


if __name__ == '__main__':
    name = sys.argv[1]
    if name.lower().endswith('.zip'):
        unpack_zipped_abc(name)
    else:
        unpack_abc(open(name, 'rb'), os.path.basename(name))
