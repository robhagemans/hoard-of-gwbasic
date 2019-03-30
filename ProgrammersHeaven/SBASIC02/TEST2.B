print "This program demonstrates all commands."
for x = 1 to 100
print x, x / 2, x, x*x
next
gosub 300
print "hello"
input h
if h < 11 then goto 200
print 12 - 4 / 2
print 100
200 a = 100 / 2
if a > 10 then print "This is OK"
print a
print a + 34
input h
print h
input "this is a test ",y
print h+y
end
300 print "This is a subroutine"
return
