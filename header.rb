class LaTeXheaders
  
  attr_reader :header, :end
  attr_accessor :opts

  def initialize(_opts={})
    @opts = {:title => 'Title Here',
     :type => 'article', 
     :font_weight => '10pt',
     :author => '',
     :font => 'Hoefler Text',
     :sans_font => 'Gill Sans',
     :mono_font => 'Andale Mono',
     :date => ''}.merge!(_opts)
  end

  def generate
  @header = 
%Q{%!TEX TS-program = xelatex
%!TEX encoding = UTF-8 Unicode

\\documentclass[#{@opts[:font_weight]}]{#{@opts[:type]}}
\\usepackage{geometry}         % See geometry.pdf to learn the layout options. There are lots.
\\geometry{letterpaper}        % ... or a4paper or a5paper or ... 
%\\geometry{landscape}         % Activate for for rotated page geometry
\\usepackage[parfill]{parskip} % Activate to begin paragraphs with an empty line rather than an indent
\\usepackage{graphicx}
\\usepackage{hyperref}
\\usepackage{wrapfig}
\\usepackage{longtable}
\\usepackage{amsmath}
\\usepackage{amssymb}
\\usepackage{color}
\\usepackage{fancyvrb}

\\usepackage{fontspec,xltxtra,xunicode}
\\defaultfontfeatures{Mapping=tex-text}
\\setromanfont[Mapping=tex-text]{#{@opts[:font]}}
\\setsansfont[Scale=MatchLowercase,Mapping=tex-text]{#{@opts[:sans_font]}}
\\setmonofont[Scale=MatchLowercase]{#{@opts[:mono_font]}}

\\title{#{@opts[:title]}}
\\author{#{@opts[:author]}}
\\date{#{@opts[:date]}}

\\begin{document}
\\maketitle
\\#{@opts[:pagestyle_empty]}\pagestyle{empty}}

  @end = "\n\\end{document}"
  end

end

