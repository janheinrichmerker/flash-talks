%%% DATE. October 10th, 2023.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lecture}
 [2023/10/10 v2.4 Basic class for presentations.]

\usepackage[german,main=american]{babel}
\usepackage{fix-cm}% CM fonts including math fonts in all sizes. Successor of the type1cm package. \cf{https://ctan.org/pkg/fix-cm}
\usepackage[T1]{fontenc}

%%% NOTES. (fontenc)
%%%
%%% For pdflatex [T1]{fontenc} is highly recommended since it will otherwise default to the original TeX OT1 encoding: accented letters will be constructed using the \accent primitive rather than using an accented character from the font. Also, other glyph differences will be observed (see the glyph for \textbackslash for instance).
%%% \cf{https://texfaq.org/FAQ-why-inp-font}
%%%
%%% For luatex and xetex [T1]{fontenc} is necessary for German umlauts. Note that the fontspec package provides a solution without the fontenc package (see below).
%%% \cf{https://tex.stackexchange.com/questions/412757/do-i-need-to-use-usepackaget1fontenc-if-i-use-lualatex}


%%% NOTES. (determine \paperwidth and \paperheight for an aspect ratio)
%%%
%%% 1. Find optimum legibility conditions in a standard projection setting (beamer projects to a wall in a lecture hall) by checking whether the projected normal-size characters have the desired size for the audience. Consider the maximum square projection area on the wall and count the number, N, of normal-size characters that can be shown in this quadratic area.
%%% 2. Indendent of Step 1, choose the normal font size you want to work with on your computer. Here, we use 17pt as normal font size in order to obtain a 1:1 correspondence when printing, viewing, or editing slides and artwork in Adobe illustrator or similar.
%%% 3. Compute the side length, l, of a quadratic (Latex) slide such that N characters (N determined within Step 1) of the chosen normal font size (here: 17pt) fit exactly in the square (see below: area ~ l^2, l ~ \@tempdima).
%%% 4. Assume that the legibility is maintained for an area of non-quadratic presentation, x*y, (-> aspect ratio x:y) if x*y equals l^2. Rationale: the projected beamer area typically exploits the wall size, which is a constant. Under this assumption the values for x and y follow from the identity l^2 = x*y. Compute, under the aspect ratio constraint, width and height of the non-quadratic slide area such that it equals the quadratic slide area: width = sqrt(area)*sqrt(ratio), height = sqrt(area)/sqrt(ratio). Since tex cannot compute the exponential series, the square roots are provided as constants below.
%%% \cf{<code-in-progress>/code-stein/texmf/stein-tex-programming-notes.txt}



%%% Options.
\newcommand\ptsize{}
\newcommand\figurescale{}
\newcommand\widthscale{}
\newcommand\heightscale{}
\newcommand\lnfontfamily{}
\newcommand\nimbus{nimbus}
\newcommand\texgyre{texgyre}
\def\legacy{}% We use \def to enable a test via \ifx, which compares tokens only.

\usepackage{iftex}
%%% \cf{https://texfaq.org/FAQ-whatengine}
%%% \cf{/usr/share/texlive/texmf-dist/tex/generic/iftex/iftex.sty}
\ifPDFTeX
\usepackage{inputenc}% Inputenc is not designed for xetex or luatex, only UTF-8 supported.
\DeclareOption{latin1}{\inputencoding{latin1}}
\DeclareOption{utf8}{\inputencoding{utf8}}
\fi

\DeclareOption{17pt}{% Normal size.
  \renewcommand\ptsize{17r}
  \@tempdima=7.94in% area = 63.0in^2. See above: The area is the result of (1) determining N and (2) choosing a normal font size to work with (here: 17pt).
  \renewcommand\figurescale{1.0}}

\DeclareOption{1:1}{% 1.0, the square
  \renewcommand\widthscale{1.0}% sqrt(1/1)
  \renewcommand\heightscale{1.0}}% sqrt(1/1)
\DeclareOption{5:4}{% 1.25
  \renewcommand\widthscale{1.1180}% sqrt(5/4)
  \renewcommand\heightscale{0.8944}}% sqrt(4/5)
\DeclareOption{9:7}{% 1.29, bs-reading.cls
  \renewcommand\widthscale{1.1339}% sqrt(9/7)
  \renewcommand\heightscale{0.8819}}% sqrt(7/9)
\DeclareOption{4:3}{% 1.33, beamer.cls, powerpoint 2010
  \renewcommand\widthscale{1.1547}% sqrt(4/3)
  \renewcommand\heightscale{0.8660}}% sqrt(3/4)
\DeclareOption{17:12}{% 1.41, A4 landscape
  \renewcommand\widthscale{1.1892}% sqrt(sqrt(2))
  \renewcommand\heightscale{0.8409}}% sqrt(1/sqrt(2))
\DeclareOption{3:2}{% 1.5
  \renewcommand\widthscale{1.2247}% sqrt(3/2)
  \renewcommand\heightscale{0.8165}}% sqrt(2/3)
\DeclareOption{8:5}{% 1.6
  \renewcommand\widthscale{1.2649}% sqrt(8/5)
  \renewcommand\heightscale{0.7906}}% sqrt(5/8)
\DeclareOption{16:9}{% 1.78, powerpoint > 2013
  \renewcommand\widthscale{1.3333}% sqrt(16/9)
  \renewcommand\heightscale{0.7500}}% sqrt(9/16)

\DeclareOption{nimbus}{\renewcommand\lnfontfamily{nimbus}}
\DeclareOption{texgyre}{\renewcommand\lnfontfamily{texgyre}}

\DeclareOption{american}{\AtBeginDocument{\selectlanguage{american}}}
\DeclareOption{english}{\AtBeginDocument{\selectlanguage{english}}}
\DeclareOption{german}{\AtBeginDocument{\selectlanguage{german}}}

\DeclareOption{legacy}{\renewcommand\legacy{true}}% Every non-empty value will work.

\ExecuteOptions{utf8,17pt,4:3,nimbus,american}
\ProcessOptions*% \ProcessOptions* processes the options in the calling order while \ProcessOptions in the order of option declarations.
%%% \cf{https://tex.stackexchange.com/questions/61487/processoptions-and-processkeyvaloptions}
%%% \cf{https://tex.stackexchange.com/questions/21171/mutually-exclusive-options-in-packages}



%%% Font sizes and parskips.
\input{size\ptsize.clo}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}

\setlength\parskip{0.4\baselineskip}

\newskip\bsparskip
\setlength\bsparskip{0.4\baselineskip}
\newcommand{\bspar}[1]{\par\vspace*{#1\bsparskip}}% \bspar0 = \par.

%%% NOTES. (parskip)
%%%
%%% Note that \parskip is redefined in different environments, e.g., 1.5pt and 0.0pt within the itemize and minipage environments respectively. \bsparskip does not depend on the environment but \par does, so that \bspar will generate an environment-dependent \par plus an environment-independent \vspace skip. Altogether, \bspar can be considered as rather environment-independent. Also note that the difference between \newline and \par is intricate: \par is practically the only (and suggested) way to leave hmode and enter vmode.
%%% \cf{https://tex.stackexchange.com/questions/82664/when-to-use-par-and-when-newline-or-blank-lines}
%%% \cf{https://tex.stackexchange.com/questions/235848/how-to-leave-horizontal-mode}

\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301



%%% Slide area. \cf[p.416]{Kopka92}
\setlength\paperwidth{\widthscale\@tempdima}
\setlength\paperheight{\heightscale\@tempdima}

\hoffset=-1in% Adjust the default printer offsets. \cf[command index, p.418]{Kopka92}
\voffset=-1in

\oddsidemargin=12pt% Left border to slide area.
\let\evensidemargin\oddsidemargin
\topmargin=4pt% Top border to slide area.

\setlength\headheight{0pt}
\setlength\headsep{0pt}
\setlength\topskip{1.0\baselineskip}% Defines the distance from \topmargin to the baseline of the first line of text. 
\setlength\footskip{0.5\baselineskip}% Defines the distance from the textarea to the baseline of the bottom line of text of the footer.. 

\textwidth=\paperwidth
\textheight=\paperheight
\advance\textwidth  by -2.0\oddsidemargin% Ensure border left and right.
\advance\textheight by -2.0\topmargin% Ensure border top and bottom.
\advance\textheight by -\headheight% Reserve space for head.
\advance\textheight by -\headsep% Reserve space for headsep.
\advance\textheight by -\footskip% Reserve space for footer.

\onecolumn
\raggedright
\raggedbottom
\sloppy



%%% Indentation and labels.
\AtBeginDocument{
%%% Be careful when using relative units such as em and ex. The evaluation of \setlength here will refer to cmr (computer modern roman) (at 17pt). Only at/after the beginning of the document, the slide font (such as phv) is used as reference. E.g., 2.5em under cmr corresponds to 2.35em under phv (helvetica) at 17pt. Note that absolute units such as pt are not affected, their setting is independent of the current font.
%%% For debugging purposes:
  % \fontfamily{phv}\selectfont
  % \fontfamily{cmr}\selectfont
  % \fontsize{17}{23}\selectfont
  % \fontsize{14}{18}\selectfont
  %
  \parindent=0pt
  \setlength\leftmargini   {2.5em}
  \leftmargin\leftmargini
  \setlength\leftmarginii  {1.5em}
  \setlength\leftmarginiii {1.5em}
  \setlength\leftmarginiv  {1.0em}
  \setlength\leftmarginv   {0.5em}
  \setlength\leftmarginvi  {0.5em}
  \setlength  \labelsep    {0.75em}
  \setlength  \labelwidth{\leftmargini}
  \addtolength\labelwidth{-\labelsep}
}

\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{\small(\theenumii)}
\newcommand\labelenumiii{\small(\theenumiii)}
\newcommand\labelenumiv{\small\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{{\footnotesize\ding{113}}}
\newcommand\labelitemii{{\normalfont\bfseries \textendash}}
\newcommand\labelitemiii{\textbullet}
\newcommand\labelitemiv{\textperiodcentered}

\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.5\p@}
\renewcommand \theequation {\@arabic\c@equation}

\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}



%%% Fonts.

%%% ß with luatex and xetex. Needs UTF8-encoding of this (lecture.cls) file. We hence have commented out the respective lines below.
\ifLuaTeX
 %\catcode`\ß=13 \defß{\ss}% Commented out to work with a latin1-encoded lecture.cls.
\fi
\ifXeTeX
 %\catcode`\ß=13 \defß{\ss}% Commented out to work with a latin1-encoded lecture.cls.
\fi
%%% \cf[catcode]{https://tex.stackexchange.com/questions/158511/lualatex-german-special-character-%C3%9F-with-newpxtext}
%%% \cf[fontspec]{https://tex.stackexchange.com/questions/496630/lualatex-problems-with-german-characters}
%%% \cf[newunicodechar]{https://tex.stackexchange.com/questions/171401/capital-%E1%BA%9E-in-latex-xetex-lualatex-whatever}

%%% Capital ß with luatex and xetex.
%%% \usepackage{newunicodechar}
%%% \newunicodechar{ß}{\ss}
%%% \renewcommand{\SS}{\iffontchar\font"1E9E \symbol{"1E9E}\else SS\fi}
%%% \cf{https://tex.stackexchange.com/questions/171401/capital-%E1%BA%9E-in-latex-xetex-lualatex-whatever}


\ifx\lnfontfamily\nimbus
  \renewcommand{\rmdefault}{phv}% Helevetica via NimbusSanL.
  %%% Alternative.
  %%% \usepackage{helvet}\renewcommand{\familydefault}{\sfdefault}
  \renewcommand{\ttdefault}{pcr}% Courier via NimbusMonL.
  \DeclareMathAlphabet{\mathit}{T1}{phv}{m}{it}% via NimbusSanL.
  \DeclareMathAlphabet{\mathrm}{T1}{phv}{m}{n}% via NimbusSanL.
  \DeclareMathAlphabet{\mathitbf}{T1}{ptm}{b}{it}% via NimbusRomNo9L.
\fi

\ifx\lnfontfamily\texgyre
  \renewcommand{\rmdefault}{qhv}% Helevetica via TeXGyreHeros.
  %%% Alternative.
  %%% \usepackage{tgheros}\renewcommand{\familydefault}{\sfdefault}
  \renewcommand{\ttdefault}{qcr}% Courier via TeXGyreCursor.
  %%% Alternative.
  %%% \usepackage{tgcursor}
  \DeclareMathAlphabet{\mathit}{T1}{qhv}{m}{it}% via TeXGyreHeros.
  \DeclareMathAlphabet{\mathrm}{T1}{qhv}{m}{n}% via TeXGyreHeros.
  \DeclareMathAlphabet{\mathitbf}{T1}{qtm}{b}{it}% via TeXGyreTermes.
\fi
%%% \cf{https://tex.stackexchange.com/questions/212357/how-to-have-helvetica-or-helvet-font-with-lualatex-having-similar-look-as-with-p}


%%% Alternative with fontspec. Requires luatex and xetex. Example:
%%% \usepackage{fontspec}
%%% \setmainfont{teXgyreheros}
%%% \setmainfont{nimbussansl}% Synonymous: zhv, nimbussansl, NimbusSansL, Nimbus Sans L, etc.

%%% \renewcommand{\ttdefault}{lmtt}% Latin Modern monospace alternative.
%%% Font family names.
%%% \cf{https://www.overleaf.com/learn/latex/Font_typefaces#Reference_guide}


\DeclareMathAlphabet{\mathcalbf}{OMS}{pzc}{b}{n}

\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}



%%% Slide environment.
\usepackage{collect}
\usepackage{expandonce_sauer}% expandonce.sty with macro \expandoncesauer (formerly \expandonce). Renamed to \expandoncesauer since the etools package has also an \expandonce macro, which is imported into hyperref.sty v7.00y.

\newsavebox{\slideheadbox}% We use a box to measure width and height of the slidehead argument.
\newenvironment{bsslide}[1][]{%
  % #1 slide head.
  \def\slideheadtext{#1}
  \savebox{\slideheadbox}{#1}
  \newpage\normalsize% \clearpage prohibits use of \twocolumn.
  \collectinmacro\@lastslide{}{}}
  {\endcollectinmacro%
    \expandoncesauer\@lastslide\@lastslide\lastslide% Expand \lastslide (3rd argument) found in \@lastslide (1st argument) and redefine \@lastslide (2nd argument). See expandonce.dtx.
    \slidehead{\slideheadtext}% Output starts always at \topskip.
    \@lastslide% Output \lastslide.
    \global\let\lastslide\@lastslide}

\newcommand{\slidehead}[1]{%
  % #1 slide head.
  {\bsslideheadstyleaux #1}%
  % Line skip only if both width and height of #1 are larger than 0.0pt.
  \ifnum\ifdim\ht\slideheadbox=0pt \ifdim\wd\slideheadbox=0pt 0\else 1\fi \else 1\fi = 1% Evaluates to 0 if width and height are 0.0pt.
  % Alternative. Line skip if the height of #1 is larger than 0.0pt. Enables \smash{\slideheadtext} to continue in first line.
  % \ifdim\ht\slideheadbox>0pt
    \vskip-1\parskip\fi}% Subheading closer at \slidehead. To get standard skip use \vskip0\parskip (= \par).

\newcommand{\bsslideheadstyle}[1]{%
  % #1 Style commands for the \slideheadtext.
  \renewcommand{\bsslideheadstyleaux}{#1}}
\newcommand{\bsslideheadstyleaux}{\large\bfseries}


\newcommand{\bscollection}[1]{%
  \renewcommand{\bscollectionaux}{\ifx\\#1\\\else#1\fi}
  \hypersetup{pdfsubject={#1}}}% Metadata for pdf file.
\newcommand{\bscollectionaux}{}


\newcounter{bspart}
\newcommand{\bsparthead}{\chaptername~\bscollectionaux:\Roman{bspart}}

\newenvironment{bspartenumerate}[1][\value{bspart}]{%
  \begin{enumerate}
    \renewcommand{\labelenumi}{\Roman{enumi}.}
    \setcounter{enumi}{#1}\addtocounter{enumi}{-1}}
  {\end{enumerate}}

\newcommand{\bspartname}[1]{%
  \renewcommand{\bspartnameaux}{#1}
  \hypersetup{pdftitle={#1}}}% Metadata for pdf file.
\newcommand{\bspartnameaux}{}


\newcommand{\bsauthor}[1]{%
  \renewcommand{\bsauthoraux}{\ifx\\#1\\\else{\textcopyright\,#1}\fi}
  \hypersetup{pdfauthor={#1}}}% Metadata for pdf file.
\newcommand{\bsauthoraux}{\textcopyright\,\textbackslash bsauthor}

\newcommand{\bsyear}[1]{\renewcommand{\bsyearaux}{#1}}
\newcommand{\bsyearaux}{\textbackslash bsyear}


\newcommand{\bsfoot}[1]{\renewcommand{\bsfootaux}{#1}}
\newcommand{\bsfootaux}{\textbackslash bsfoot\hfill}
\newcommand{\footfont}{\fontfamily{\rmdefault}\fontsize{8}{0}\fontseries{m}\fontshape{n}\selectfont\color{mediumgray}}
\def\ps@plain{\def\@oddfoot{\footfont\bsfootaux\\}}
\pagestyle{plain}
\pagenumbering{arabic}% Defines \thepage. \thepage must be defined before inclusion of hyperref package to use pdfpagelabels.

\bsfoot{%
  % Page identifier. [<collection>:][<part>-]<page>
  \setbox0=\hbox{\bscollectionaux}\ifdim\wd0>0pt\bscollectionaux:\fi% Check for nonempty collection code.
  \ifnum\value{bspart}>0\Roman{bspart}-\fi% Check for nonzero part number.
  \arabic{page}%
  % Rest of foot. [<partname>] ... (c)<author> <year>
  \quad\bspartnameaux\hfill\bsauthoraux~\bsyearaux}



%%% Color declarations and commands.

%%% NOTES. (color schemes)
%%%
%%% webis{ blue | green | red | purple | yellow }{ A{ 1 | 2 | 3 } |    % Area. 
%%%                                                TL{ 1 | 2 } |       % Text/Line.
%%%                                                LD }                % Latex dark.
%%%
%%% \cf{<lecturenotes>}/lecturenotes-generic/lecturenotes-tex/lecturenotes-color-scheme.tex|pdf}
%%% \cf{<lecturenotes>}/lecturenotes-generic/lecturenotes-ai/figures/ai-version-cs2/empty-slide_current.ai}
%%%
%%% \cf{https://latexcolor.com/}
%%% \cf{https://en.wikibooks.org/wiki/LaTeX/Colors#The_68_standard_colors_known_to_dvips}

\RequirePackage[table]{xcolor}

\definecolor{webisblueA1}    {HTML}{D3F8F7} 
\definecolor{webisblueA2}    {HTML}{90D7DE} 
\definecolor{webisblueA3}    {HTML}{68B4C2} 
\definecolor{webisblueTL1}   {HTML}{3A91A5} 
\definecolor{webisblueTL2}   {HTML}{156A82} 
\definecolor{webisblueLD}    {HTML}{034257} 

\definecolor{webisgreenA1}   {HTML}{E6F8B8} 
\definecolor{webisgreenA2}   {HTML}{9ED977} 
\definecolor{webisgreenA3}   {HTML}{62BA61} 
\definecolor{webisgreenTL1}  {HTML}{349850} 
\definecolor{webisgreenTL2}  {HTML}{12753E} 
\definecolor{webisgreenLD}   {HTML}{02522B} 

\definecolor{webisredA1}     {HTML}{FFDFDB} 
\definecolor{webisredA2}     {HTML}{FFAB9E} 
\definecolor{webisredA3}     {HTML}{FF6F52} 
\definecolor{webisredTL1}    {HTML}{E64727} 
\definecolor{webisredTL2}    {HTML}{9E3723} 
\definecolor{webisredLD}     {HTML}{5B181B} 

\definecolor{webispurpleA1}  {HTML}{F5DEFC} 
\definecolor{webispurpleA2}  {HTML}{D6ACFA} 
\definecolor{webispurpleA3}  {HTML}{BB86F3} 
\definecolor{webispurpleTL1} {HTML}{9951E6} 
\definecolor{webispurpleTL2} {HTML}{6D34A7} 
\definecolor{webispurpleLD}  {HTML}{3E235D} 

\definecolor{webisyellowA1}  {HTML}{FFEC99} 
\definecolor{webisyellowA2}  {HTML}{FFC640} 
\definecolor{webisyellowA3}  {HTML}{E8A01D} 
\definecolor{webisyellowTL1} {HTML}{C78824} 
\definecolor{webisyellowTL2} {HTML}{A16628} 
\definecolor{webisyellowLD}  {HTML}{835327} 


%%% Additional colors.
\definecolor{ultralightyellow}{rgb}{1.00,0.98,0.87}
\definecolor{lightyellow}{rgb}{1.00,0.97,0.70}

%%% Shades of gray.
\definecolor{ultralightgray}{gray}{0.90}
\definecolor{lightgray}{gray}{0.80}
\definecolor{mediumgray}{gray}{0.60}
\definecolor{darkgray}{gray}{0.40}

%%% Predefined standard colors.
\newcommand{\defaultcolor}{webisblueLD}
\newcommand{\altcolor}{webisgreenA3}
\newcommand{\emcolor}{webisredTL1}
\newcommand{\keywordcolor}{webispurpleTL2}


%%% Color text commands.
\newcommand{\colortext}[2][\defaultcolor]{{\color{#1}#2}}
\newcommand{\altcolortext}[1]{{\color{\altcolor}#1}}
\newcommand{\emcolortext}[1]{{\color{\emcolor}#1}}
\newcommand{\keywordcolortext}[1]{{\color{\keywordcolor}#1}}
\newcommand{\graytext}[1]{{\color{mediumgray}#1}}



%%% Auxiliary variables.
\newcommand{\textbufferA}{}
\newcommand{\textbufferB}{}
\newcommand{\textbufferC}{}
\newcommand{\textbufferD}{}
\newcommand{\textbufferE}{}
\newcommand{\textbufferF}{}
\newcommand{\textbufferG}{}
\newcommand{\textbufferH}{}
\newcommand{\textbufferI}{}

\newcommand{\textcolorA}{}
\newcommand{\textcolorB}{}
\newcommand{\textcolorC}{}
\newcommand{\textcolorD}{}
\newcommand{\textcolorE}{}
\newcommand{\textcolorF}{}
\newcommand{\textcolorG}{}
\newcommand{\textcolorH}{}
\newcommand{\textcolorI}{}



%%% Hyperref setup and hyperlink styles.
\usepackage{hyperref}% \thepage must be defined before and \coloritem after inclusion of hyperref package.
\RequirePackage{ifthen}

\AtBeginDocument{\hypersetup{
  colorlinks=true,% colorlinks=false enables pdfborder, colorlinks=true disables pdfborder. 
  pdfborder={0 0 0},
  filecolor=\defaultcolor,% URLs without an http schema declaration are interpreted as file names.
  linkcolor=\defaultcolor,
  urlcolor=\defaultcolor,
  baseurl=https://webis.de/downloads/lecturenotes/,
  extension=,% Defaults to pdf, saved in \XR@ext. If unequal pdf, \hyperref will extend a partial URL (such as an interunit link) by \@baseurl. This is the desired behavior.
}}
%%% Modify hyperref settings from within the document (does not work for all options, see Section 5 of hyperref-doc.pdf):
% \setkeys{Hyp}{pdfborder={0 0 0},filecolor=\defaultcolor,linkcolor=\defaultcolor,urlcolor=\defaultcolor}
% \hyperbaseurl{https://webis.de/downloads/lecturenotes/}

\newcommand{\bshyperref}[4][\noexpand\empty]{%
  % #1 Optional style commands (underline, color, font, \interunitrefstyle, etc.). In particular, we distinguish whether the optional argument #1 is stated but empty (-> no underlining) or whether #1 is omitted (-> default underlining).
  % \cf{https://tex.stackexchange.com/questions/617735/how-can-i-differentiate-in-newcommand-between-an-unused-optional-argument-and-a}
  %
  % #2 Absolute or relative URL, or empty.
  % #3 Label (if #2 is empty) or fragment identifier (if #2 is a URL).
  % #4 Anchor. The anchor can be anything - also a figure or a table, for which we omit underlining.
  %
  \ifthenelse{\equal{#2}{}}
    % We have no URL but a hyperlink within (= intra) the unit.
    {\ifthenelse{\equal{#1}{}}
      % #1 is stated but empty.
      {\hyperref{}{}{#3}{#4}}% \typeout{Intraunit link without underlining.}
      {\ifthenelse{\equal{#1}{\noexpand\empty}}
        % #1 is omitted.
        {\hyperref{}{}{#3}{\intraunitrefstyle{#4}}}% \typeout{Intraunit link with default underlining.}
        % #1 is stated and not empty.
        {\hyperref{}{}{#3}{#1{#4}}}}}% \typeout{Intraunit link with optional style.}
    % We have an absolute or relative URL.
    {\ifthenelse{\equal{\detokenize{#1}}{\detokenize{\interunitrefstyle}}}
      % We recognized a link between (= inter) lecturenotes units.
      {\hyperref{\@baseurl #2}{}{#3}{{\interunitrefstyle{#4}}}}% \typeout{Interunit link with default underlining.} Link to resource at \hyperbaseurl+#2.
      % We have not recognized an interunit link.
      {\ifthenelse{\equal{#1}{}}
        % #1 is stated but empty.
        {\hyperref{#2}{}{#3}{#4}}% \typeout{URL without underlining.}
        {\ifthenelse{\equal{#1}{\noexpand\empty}}
        % #1 is omitted.
        {\hyperref{#2}{}{#3}{\bshyperrefstyle{#4}}}% \typeout{URL with default underlining.}
        % #1 is stated and not empty.
        {\hyperref{#2}{}{#3}{#1{#4}}}}}}% \typeout{URL with optional style.} Link to resource at #2 (absolute URL) or at \hyperbaseurl+#2 (interunit link). The latter requires that the 'extension' option does not equal 'pdf'.
  }

\usepackage[normalem]{ulem}
%%% \cf{/usr/share/texlive/texmf-dist/tex/generic/ulem/ulem.sty}
\newcommand{\bshyperrefstyle}{\fontfamily{\rmdefault}\selectfont\uline}
\newcommand{\intraunitrefstyle}{\fontfamily{\rmdefault}\selectfont\udash}
\newcommand{\interunitrefstyle}{\fontfamily{\rmdefault}\selectfont\uwave}
\def\udashaux{\bgroup
  \markoverwith{\kern0.7pt\rule[-.5ex]{2pt}{\ULthickness}\kern0.7pt}\ULon}
\def\udash{\protect\udashaux}% \protect necessary to use \udash (and \intraunitrefstyle) safely in argument position.
\def\uwaveaux{\bgroup
  \markoverwith{\lower5.5\p@\hbox{\sixly \char58}}\ULon}
\def\uwave{\protect\uwaveaux}% \protect necessary to use \uwave (and \interunitrefstyle) safely in argument position.



%%% Figures and tables.
\usepackage{graphicx}
\DeclareGraphicsRule{.ai}{pdf}{*}{}% Handle ai files as pdf files.
\DeclareGraphicsExtensions{.pdf,.ai,.jpg,.png}% Determines sourcing sequence. 
\graphicspath{{../figures/ai-version-cs2/}{../figures/figures-others/}}% Determines search sequence.
%%% Reference a file relative to the home directory: \includegraphics{\string~/foo}.
%%% \cf{http://tex.stackexchange.com/questions/97770/reference-file-relative-to-the-home-directory}
\setkeys{Gin}{pagebox=artbox}% Use artbox instead of mediabox default. Options: mediabox, cropbox, bleedbox, trimbox, artBox. (shell: pdfinfo -box <pdf-file>)

\newcommand{\bsfigure}[2][]{%
  % #1 parameter=value list
  % #2 file name
  \vskip\parskip
  \centerline{\bsfigureaux[#1]{#2}}}

\newcommand{\bsfigureaux}[2][]{%
  % #1 parameter=value list
  % #2 file name
  \scalebox{\figurescale}{\includegraphics[#1]{#2}}}


\usepackage{booktabs}
\lightrulewidth=0.5pt
\heavyrulewidth=1pt
\aboverulesep=1pt
\belowrulesep=1pt



%%% Colored items.

%%% Redefine \item to solve the scope problem discussed here: \cf{https://latex-tutorial.com/color-latex/#text-color}
%%% Note that saving and restoring the color just before the beginning of a listing works for nested listings as well since Latex is a dynamically scoped language.
%%% \cf{https://tex.stackexchange.com/questions/693472/put-item-into-a-group-so-that-typesetting-effects-are-limited-for-the-list-entr}

\let\itemaux\item
\newcommand{\coloritem}[1][\defaultcolor]{\color{#1}\itemaux}% \coloritem must be defined after including the hyperref package to avoid warnings 'destination with the same identifier'.
\newcommand{\grayitem}{\coloritem[mediumgray]}

%%% Use \AddToHook and check whether itemcolor is set. If itemcolor is set, redefine \item as \coloritem; otherwise resort to the original \item definition. This check is necessary since \AddToHook for setting the itemcolor is applied here for enumerate and itimize only, but, various environments also rely on the \item command and will report an undefined itemcolor if \item is redefined as \coloritem: definition, lemma, proof, tabbing, theorem, verbatim.
%%% \cf{mirrors.ctan.org/macros/latex/base/lthooks-doc.pdf}
\AddToHook{env/enumerate/begin}{\colorlet{itemcolor}{.}}
\AddToHook{env/itemize/begin}{\colorlet{itemcolor}{.}}
\renewcommand{\item}{%
  \@ifundefined{\string\color@itemcolor}
    {\itemaux}% {\typeout{^^JBS: itemcolor undefined.^^J}\itemaux}
    {\coloritem[itemcolor]}}
%%% \renewcommand{\item}{\coloritem[itemcolor]}% Break at environments that use \item without having defined itemcolor.

%%% Alternative. Use \renewenvironment to restrict the scope of the redefinition of \item to the environments enumerate and itimize.
%%% \cf{https://tex.stackexchange.com/questions/315454/how-to-shallow-renewenvironment-of-itemize}
% \let\itemizeaux=\itemize
% \let\enditemizeaux=\enditemize
% \renewenvironment{itemize}{%
%   \colorlet{itemcolor}{.}
%   \renewcommand{\item}{\coloritem[itemcolor]}%
%   \itemizeaux}{\enditemizeaux}
% \let\enumerateaux=\enumerate
% \let\endenumerateaux=\endenumerate
% \renewenvironment{enumerate}{%
%   \colorlet{itemcolor}{.}
%   \renewcommand{\item}{\coloritem[itemcolor]}%
%   \enumerateaux}{\endenumerateaux}


%%% Color debugging and support.
%%% \cf{http://mirrors.ctan.org/macros/latex/contrib/xcolor/xcolor.pdf}
% \def\curcol{\csname\string\color@.\endcsname}
%%% \cf{https://tex.stackexchange.com/questions/384903/how-to-get-a-textual-representation-of-the-current-color}
% \newcommand{\bscolordefined}[1]{'#1' \@ifundefined{\string\color@#1}{undefined.}{defined.}}
%%% \cf{https://tex.stackexchange.com/questions/119059/is-color-undefined}



%%% Additional text elements.
\newcommand{\Ni}{(1)~}
\newcommand{\Nii}{(2)~}
\newcommand{\Niii}{(3)~}
\newcommand{\Niv}{(4)~}
\newcommand{\Nv}{(5)~}
\newcommand{\Nvi}{(6)~}


\RequirePackage{xspace}
\RequirePackage{pifont}
\RequirePackage{latexsym}% Necessary for \leadsto.

\newcommand{\bsarrow}[1][.]{{\color{#1}\ding{220}}\xspace}
\newcommand{\bsbb}{\quad$\leadsto$ {\fontencoding{OMS}\fontfamily{pzc}\fontshape{n}\selectfont\iflanguage{german}{TAFEL}{BO\kern-3ptARD}}}
\newcommand{\bscite}[1]{\mbox{\fontfamily{\rmdefault}\fontseries{m}\fontshape{n}\selectfont\footnotesize[#1]}}
\newcommand{\bscont}{{\footnotesize\mdseries\upshape\ \ \iflanguage{german}{(Fortsetzung)}{(continued)}}}


\RequirePackage{soul}
\setstcolor{blue}
\newcommand{\bscom}[2]{%
  % #1 Original text.
  % #2 Replacement text.
  \st{#1}{\color{blue}\fontsize{12}{12}\selectfont\,#2}}



%%% Mathematical environments.
\RequirePackage{ntheorem}
%%% \cf{http://mirrors.ctan.org/macros/latex/contrib/ntheorem/ntheorem.pdf}
%%% \cf{/usr/share/texlive/texmf-dist/tex/latex/ntheorem/}

\bgroup
  \theoremheaderfont{\fontseries{b}\fontshape{n}\selectfont\color{\defaultcolor}\rule[-1.0ex]{0em}{0ex}}
  \theorembodyfont{\fontshape{n}\selectfont}
  \theorempreskip{0.8\baselineskip}% Adjusted to standard paragraph skip.
  \theorempostskip{0.0\baselineskip}% Adjusted to standard paragraph skip.
  \theoremstyle{break}
  \newtheorem{theorem}{\iflanguage{german}{Satz}{Theorem}\small}
  \newtheorem{corollary}[theorem]{\iflanguage{german}{Korollar}{Corollary}\small}
  \newtheorem{definition}[theorem]{Definition\small}
  \newtheorem{lemma}[theorem]{Lemma\small}
  \theoremstyle{nonumberbreak}
  \newtheorem{proof}{\iflanguage{german}{Beweis}{Proof}\small}
\egroup



%%% Load part-specific latex code.
\IfFileExists{\jobname.sty}{\usepackage{\jobname}}{}



%%% Legacy declarations and commands.
\ifx\legacy\empty\else
\AtBeginDocument{
%%% Previous versions of \lecture.cls defined the following dimensions when cmr was still the active font (i.e., too early), leading to the slightly smaller values defined below when phv became active.
  \setlength\leftmargini   {2.35em}
  \leftmargin\leftmargini
  \setlength\leftmarginii  {1.41em}
  \setlength\leftmarginiii {1.41em}
  \setlength\leftmarginiv  {0.94em}
  \setlength\leftmarginv   {0.47em}
  \setlength\leftmarginvi  {0.47em}
  \setlength  \labelsep    {0.7em}
  \setlength  \labelwidth{\leftmargini}
  \addtolength\labelwidth{-\labelsep}
}
\fi

\ifx\legacy\empty\else
  \renewenvironment{bsslide}[1][]{%
    % #1 slide head.
    \def\slideheadtext{#1}
    \newpage\normalsize\mbox{}% \clearpage prohibits use of \twocolumn. \clearpage is superior \newpage for perfect restart of \lastslide.
    \collectinmacro\@lastslide{}{}}
    {\endcollectinmacro%
      \expandoncesauer\@lastslide\@lastslide\lastslide% Expand \lastslide in \@lastslide and redefine \@lastslide.
      \slidehead{\slideheadtext}% Output starts always at \topskip.
      \@lastslide% Output \lastslide.
      \global\let\lastslide\@lastslide}
  \renewcommand{\slidehead}[1]{%
    \ifx#1\empty\else{\large\bfseries#1}\vskip-\parskip\fi}% Subheading closer at \slidehead. To get standard skip use \vskip0\parskip (= \par).
\fi

\ifx\legacy\empty\else
  \let\sdashuline\udash
\fi

\ifx\legacy\empty\else
  \definecolor{upbblue}{rgb}{0.04,0.12,0.38}
  \definecolor{upbtextorange}{rgb}{0.88,0.42,0.03}
  \definecolor{upbtextgreen}{rgb}{0.36,0.67,0.15}
  \definecolor{violet}{rgb}{0.58,0.07,0.49}
  \renewcommand{\defaultcolor}{upbblue}
  \renewcommand{\altcolor}{upbtextgreen}
  \renewcommand{\emcolor}{upbtextorange}
  \renewcommand{\keywordcolor}{violet}
  \renewcommand{\colortext}[2][]{{\color{\defaultcolor}{#2}}}
\fi

\ifx\legacy\empty\else
  \renewcommand{\bshyperref}[4][\bshyperrefstyle]{%
    % #1 Optional style commands (underline, color, font, \interunitrefstyle, \intraunitrefstyle).
    % #2 Absolute or relative URL.
    % #3 Fragment identifier.
    % #4 Clickable text.
    \ifthenelse{\equal{\detokenize{#1}}{\detokenize{\interunitrefstyle}}}%
    {\hyperref{\@baseurl #2}{}{#3}{{#1{#4}}}}% Look for resource at \hyperbaseurl+#2.
    {\hyperref{#2}{}{#3}{{#1{#4}}}}}% Look for resource file at #2 (absolute) or \hyperbaseurl+#2 (relative)
\fi

\ifx\legacy\empty\else
  \newcommand{\blackitem}{\coloritem[black]}
  \let\item\blackitem
  \newcommand{\blacktext}[1]{{\color{black}#1}}
  \newcommand{\whitetext}[1]{{\color{white}#1}}
  \renewcommand{\bsarrow}[1][mediumgray]{{\color{#1}\ding{220}}\xspace}
\fi

\ifx\legacy\empty\else
  \newenvironment{quote}
    {\list{}{\rightmargin\leftmargin}\item\relax}
    {\endlist}
  %%% \cf{https://tex.stackexchange.com/questions/20687/does-newenvironment-have-a-provideenvironment-cousin-as-newcommand-has-prov}
\fi

\ifx\legacy\empty\else
  \providecommand{\nat}{\mathbf{N}}
  \providecommand{\integer}{\mathbf{Z}}
  \providecommand{\rat}{\mathbf{Q}}
  \providecommand{\real}{\mathbf{R}}
  \renewcommand{\exp}{\ensuremath{\mathop{\mathrm{exp}}}}
  \renewcommand{\log}{\ensuremath{\mathop{\mathrm{log}}}}
  \renewcommand{\min}{\ensuremath{\mathop{\mathrm{min}}}}
  \renewcommand{\max}{\ensuremath{\mathop{\mathrm{max}}}}
\fi


\endinput
%%

