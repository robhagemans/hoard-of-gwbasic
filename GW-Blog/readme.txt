    GW-Blog - A Static Blog Generator
    =================================

    This currently incomplete repository contains a static blog
    generator written in GW-BASIC.  The whole package is designed to
    run in GW-BASIC 2 or higher.  The generator will convert documents
    in a simplistic subset of the Textile markup language to HTML and
    add headers and footers based on templates.  The templates
    themselves do feature a severely limited templating engine as
    well.

    Requirements
    ------------
    
    GW-Blog has been designed to run on GW-BASIC version 2 or higher.
    It may work on other BASIC interpreters that are compatible with
    GW-BASIC since it relies entirely on string and shell commands.
    
    GW-Blog also requires MS-DOS 3 or higher. The static site
    generator relies on a significant number of SHELL calls for file
    operations.  Alternative DOSes may be problematic because some
    parsing of the output from the DIR command is used, and it assumes
    an MS-DOS-style output.
    
    The included batch file, "GO.BAT," assumes that the BASIC
    interpreter is named "GWBASIC" and exists on the path.
    
    The entire package was designed to work on an up-to-date Rainbow
    100 personal computer from Digital Equipment Corporation, but it
    will run fine on any MS-DOS machine that meets the above
    requirements.
    
    Installation
    ------------
    
    GW-Blog should be unzipped to a sensible location.  Your blog will
    not be generated in this directory, but, rather, it's own
    directory.  It should be convenient so that the user can execute
    the site generator easily.
    
    Setting Up a Blog
    -----------------
    
    GW-Blog relies on text files formatted using a subset of Textile
    markup language in combination with HTML templates.  The software
    understands two types of content: pages and posts.  Pages represent
    static pages, such as an "About" page or a list of interesting
    links, that are not blog entries per se.  Posts represent dated
    blog entries.
    
    The directory containing the blog should be arranged as:
    
        PAGES\          Directory containing text files representing 
                        static pages for the blog
    
        POSTS\          Directory containing posts for the blog
    
        STATIC\         Static files, such as images or CSS, for the
                        blog in a flat directory (no subdirectories)
    
        POSTHDR.HTM     HTML code to be prepended to the page and post 
                        processed HTML fragments, including template
                        tags

        POSTFTR.HTM     HTML code to be appended to the page and post 
                        processed HTML fragments, including template
                        tags
                        
        CONFIG.INI      Simple configuration file that provides a blog
                        name, description, and base URL in addition to
                        any other user-defined variables for the
                        template engine.
    
    Text files containing page and post Textile must end in a ".TXT"
    extension.  While pages can be named anything, posts must be
    encoded as a date in the format: YYYYMMDD.TXT
    
    Blog Configuration File
    -----------------------
    
    The file CONFIG.INI is used to set up variables used by the template
    engine and the RSS feed generator.  The configuration file is a simple
    file containing pairs: 
    
    label=value
    
    Lines that are blank or start with a "#" sign are ignored.
    
    The RSS generator code requires the following values to be defined:
    
        * blog - the name of the blog
        * description - a brief, one-line description
        * url - the base URL from where the blog is served
    
    These values are also available in the templates, and may be included
    in the POSTHDR.HTM and POSTFTR.HTM files, as described later.

    Writing Posts and Pages
    -----------------------
    
    GW-Blog supports a substantial subset of the Textile markup
    language.  The following markup features are understood by GW-Blog:
    
        * Headings (h1., h2., etc.)
        * Paragraphs (p.)
        * Ordered and unordered lists (#, *)
        * Block quotes (bq.)
        * Text modification (bold, italics, super/subscript)
        * Links
        * Images
    
    GW-Blog's Textile processor does not support style modifiers for
    any of the above features (for example, p(text-align: center;).
    will not work).
    
    All posts and pages must include one "h1." entry, which will be
    used for the page title when creating the template and other
    support pages.
    
    Writing Header and Footer HTML Templates
    ----------------------------------------
    
    The Textile-to-HTML processed text will be prepended and appended
    with the contents of POSTHDR.HTM and POSTFTR.HTM after being
    processed by the template engine. 
    
    Template tags in GW-Blog are of the format: {% tag_name %}
    
    GW-Blog defines the following tags:
    
     * title - The page title (as defined by the first h1.)
     * next - A valid HTML link to the next post in chronological 
              order (on posts only, blank otherwise)
     * previous - A valid HTML link to the previous post in
                  chronological order (on posts only, blank otherwise)
     * latest - A valid HTML link to the latest blog post
     * postlist - A valid HTML link to a page with a list of all posts
     * date - The date of the current post (blank on pages)
     * pages - An unordered HTML list of links to all static pages

    Additionally, the following values are available from the CONFIG.INI
    file:
    
     * blog - the name of the blog
     * description - a brief, one-line description
     * url - the base URL from where the blog is served

    The user may define more variables for use in the template within the
    CONFIG.INI file.
        
    The template engine does not handle conditionals or any unlisted
    variables.  Unlisted variables can cause the template engine to lock
    up.  The template variables are only filled in for the HTML header
    and footer files, not the Textile code of a page or post itself.
    
    Running GW-Blog
    ---------------
    
    GW-Blog is shipped as multiple BASIC files that must be concatenated
    prior to use.  If you're running a version of MS-DOS, a batch file,
    GO.BAT, is included to perform three necessary actions: write
    LOC.BAS declaring the location of the blog inputs, concatenate the
    BASIC files into BLOG.BAS, and launch GW-Blog.  To use the batch
    file, the user may type:
    
        GO.BAT E:\PATH\TO\BLOG\
    
    After a wait, which may be long depending on your system, the entire
    blog should now be in the BUILD subdirectory in your blog's
    directory.
    
    License
    -------
    
    GW-Blog - A static blog generator for GW-BASIC
    Copyright (C) 2016 Jeffrey Armstrong <jeff@rainbow-100.com>
    https://bitbucket.org/ArmstrongJ/gwblog/overview    

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
