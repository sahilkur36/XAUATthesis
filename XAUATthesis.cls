% ------------------------------------------------------------------------------
% identification
% ------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}[2022/06/01]
\ProvidesClass{XAUATthesis}
[2020/08/10 v1.1.1 Xi'an University of Architecture & Techenology Thesis Template]
% ------------------------------------------------------------------------------
% initial code
% ------------------------------------------------------------------------------
\RequirePackage{kvoptions}
\SetupKeyvalOptions{%
    family=XAUAT,
    prefix=XAUAT@,
    setkeys=\kvsetkeys
}

% ------------------------------------------------------------------------------
% declaration of options
% ------------------------------------------------------------------------------
% 学位
\newif\ifXAUAT@master
\newif\ifXAUAT@doctor
\define@key{XAUAT}{degree}{%
    \XAUAT@masterfalse
    \XAUAT@doctorfalse
    \expandafter\csname XAUAT@#1true\endcsname
}

% 学位类型
\newif\ifXAUAT@academic
\newif\ifXAUAT@engineering
\define@key{XAUAT}{degreetype}{%
    \XAUAT@academicfalse
    \XAUAT@engineeringfalse
    \expandafter\csname XAUAT@#1true\endcsname
}

% 保密
\newif\ifXAUAT@none
\newif\ifXAUAT@one
\newif\ifXAUAT@two
\newif\ifXAUAT@three
\define@key{XAUAT}{secret}{%
    \XAUAT@nonefalse
    \XAUAT@onefalse
    \XAUAT@twofalse
    \XAUAT@threefalse
    \expandafter\csname XAUAT@#1true\endcsname
}

% 引用
\newif\ifXAUAT@numeric
\XAUAT@numerictrue      % 默认为数字型
\newif\ifXAUAT@authoryear
\define@key{XAUAT}{bibtype}{%
    \XAUAT@numericfalse
    \XAUAT@authoryearfalse
    \expandafter\csname XAUAT@#1true\endcsname
}

\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}

\PassOptionsToPackage{AutoFakeBold=2.17,AutoFakeSlant=true}{xeCJK}

% ------------------------------------------------------------------------------
% execution of options
% ------------------------------------------------------------------------------
\ProcessKeyvalOptions*

% 强制指定degree
\ifXAUAT@master\relax\else
    \ifXAUAT@doctor\relax\else
        \ClassError{XAUATthesis}%
                    {Please specify thesis degree in option: \MessageBreak
                    degree=[master | doctor]}{}      
    \fi
\fi

% 强制指定degreetype
\ifXAUAT@academic\relax\else
    \ifXAUAT@engineering\relax\else
        \ClassError{XAUATthesis}%
                    {Please specify the type of degree in option: \MessageBreak
                    degreetype=[academic | engineering]}{}      
    \fi
\fi

% 强制指定secret
\ifXAUAT@none\relax\else
    \ifXAUAT@one\relax\else
        \ifXAUAT@two\relax\else
            \ifXAUAT@three\relax\else
                \ClassError{XAUATthesis}%
                            {Please specify secret in option: \MessageBreak
                            secret=[none | one | two | three]}{}
            \fi
        \fi
    \fi
\fi

% 杜绝非法bibtype
\ifXAUAT@numeric\relax\else
    \ifXAUAT@authoryear\relax\else
        \ClassError{XAUATthesis}{Unknown bib type option.\MessageBreak Please check your bib type option!}{}
    \fi
\fi
% ------------------------------------------------------------------------------
% package loading
% ------------------------------------------------------------------------------
\LoadClass[a4paper,UTF8,scheme=plain,zihao=-4,openright]{ctexbook}
% \ctexset{fontset=windows} % 2021-05-26 solve warning "Font FandolSong-Regular does not contain requested(fontspec) Script" // fontset=none

% biblatex
\ifXAUAT@numeric
    \RequirePackage[backend=biber,style=gb7714-2015,gbpub=false,isbn=false,doi=false,gbtitlelink=true,url=false,sortlocale=zh__pinyin]{biblatex} 
\else
    \ifXAUAT@authoryear
        \RequirePackage[backend=biber,style=gb7714-2015ay,gbpub=false,isbn=false,doi=false,gbtitlelink=true,url=false,sortlocale=zh__pinyin]{biblatex} 
    \fi
\fi

% 
\DeclareDelimFormat[cite,parencite,textcite,citeauthor*]{andothersdelim}{} % 2023-09-04 https://github.com/hushidong/biblatex-gb7714-2015/issues/151

% % AmSTeX
\RequirePackage{amssymb}
\RequirePackage{mathtools}

% New TX font
\RequirePackage{newtxtext}
\RequirePackage{newtxmath}
\defaultfontfeatures{} % 2022-09-16 14:37:29 Fixing font cannot be found problem (TexLive 2022) https://www.overleaf.com/blog/tex-live-2022-now-available

% environ
\RequirePackage{environ}

% graphicx
\RequirePackage{graphicx}

% caption
\RequirePackage{caption}

% subcaption
\RequirePackage{subfig}

% insert pdf pages
\RequirePackage{pdfpages}
\includepdfset{fitpaper=true}

% enumitem
\RequirePackage[shortlabels]{enumitem}
\setlist{nosep}
\setlist[itemize]{left=2em..3em} % 2021-07-12

% emptypage
\RequirePackage{emptypage} 

% CJKfntef
\RequirePackage{CJKfntef}

% booktabs
\RequirePackage{booktabs}
\setlength\aboverulesep{0ex} % 2021-07-11 discontinued vertical line
\setlength\belowrulesep{0ex}

% array
\RequirePackage{array}

% longtable
\RequirePackage{longtable}

% tabularray % 2022-09-16 20:42:59
\RequirePackage{tabularray} % tblr
\UseTblrLibrary{booktabs} % use library

% multirow
\RequirePackage{multirow}

% tikz
\RequirePackage{tikz}

% setspace
\RequirePackage{setspace}

% hyperref
\RequirePackage{hyperref}
\hypersetup{%
    linktoc=all,
    bookmarksnumbered=true,
    bookmarksopen=true,
    bookmarksopenlevel=1,
    breaklinks=true,
    colorlinks=true, % 2021-05-26 true,方便查看
    plainpages=false,
    pdfborder=0 0 0,
    citecolor=blue, % 2024-03-11
}
\pdfstringdefDisableCommands{\def\cite#1{#1}} % 2022-06-07 Remove warning: token not allowed in a pdf string

\usepackage{cleveref} % 2021-07-20
\crefname{table}{表}{表}
\crefname{figure}{图}{图}
\crefname{equation}{式}{式}
\crefname{page}{页}{页}
\crefname{chapter}{章}{章}
\crefname{section}{节}{节}
\crefname{appendix}{附录}{附录}
\crefname{theorem}{定理}{定理}
\crefname{lemma}{引理}{引理}
\crefname{corollary}{推论}{推论}
\crefname{proposition}{命题}{命题}
\crefname{definition}{定义}{定义}
\crefname{example}{例}{例}
\crefname{algorithm}{算法}{算法}
\crefname{listing}{列表}{列表}
\crefname{line}{行}{行}

\crefformat{chapter}{#2第#1章#3}
\crefformat{section}{#2第#1节#3}
\crefformat{subsection}{#2第#1节#3}
\crefformat{subsubsection}{#2第#1节#3}

\crefrangeformat{chapter}{#3第#1章#4至#5第#2章#6}
\crefrangeformat{section}{#3第#1节#4至#5第#2节#6}
\crefrangeformat{subsection}{#3第#1节#4至#5第#2节#6}
\crefrangeformat{subsubsection}{#3第#1节#4至#5第#2节#6}

\crefmultiformat{chapter}{#2第#1章#3}{和#2第#1章#3}{，#2第#1章#3}{和#2第#1章#3}
\crefmultiformat{section}{#2第#1节#3}{和#2第#1节#3}{，#2第#1节#3}{和#2第#1节#3}
\crefmultiformat{subsection}{#2第#1节#3}{和#2第#1节#3}{，#2第#1节#3}{和#2第#1节#3}
\crefmultiformat{subsubsection}{#2第#1节#3}{和#2第#1节#3}{，#2第#1节#3}{和#2第#1节#3}

\newcommand{\crefpairconjunction}{和}
\newcommand{\crefmiddleconjunction}{，}
\newcommand{\creflastconjunction}{~和~}
\newcommand{\crefpairgroupconjunction}{~和~}
\newcommand{\crefmiddlegroupconjunction}{，}
\newcommand{\creflastgroupconjunction}{~和~}
% \newcommand{\crefrangeconjunction}{~至~} % 2023-09-16
\newcommand{\crefrangeconjunction}{~$\sim$~}

% 确定浮动对象的位置
\RequirePackage{float} % 2021-11-17 16:25:47

% 浮动体距离
\setlength{\floatsep}{0pt \@plus 2pt \@minus 2pt}
\setlength{\textfloatsep}{10pt \@plus 2pt \@minus 2pt}
\setlength{\intextsep}{10pt \@plus 2pt \@minus 2pt}
\setlength{\abovedisplayskip}{2pt \@plus 1pt \@minus 1pt}
\setlength{\abovedisplayshortskip}{2pt \@plus 1pt \@minus 1pt}
\setlength{\belowdisplayskip}{2pt \@plus 1pt \@minus 1pt}
\setlength{\belowdisplayshortskip}{2pt \@plus 1pt \@minus 1pt}
\renewcommand{\topfraction}{0.8}
\renewcommand{\bottomfraction}{0.3}
\renewcommand{\textfraction}{0.2}
\renewcommand{\floatpagefraction}{0.85} % 2023-08-26

% 浮动图形和表格标题样式
\DeclareCaptionLabelFormat{XAUAT}{\wuhao[1.5]\normalfont #1~#2}
\DeclareCaptionLabelSeparator{XAUAT}{\hspace{1em}}
\DeclareCaptionFont{XAUAT}{\wuhao[1.5]}
\captionsetup{labelformat=XAUAT,labelsep=XAUAT,font=XAUAT}
\captionsetup{justification=centering} % 2021-11-25 10:43:45

% bicaption
\RequirePackage[list=off]{bicaption}
\captionsetup{bi-lang=both}
\DeclareCaptionOption{bi-first}[format=hang,hangindent=-0.5em]{}
\DeclareCaptionOption{bi-second}[format=hang,hangindent=-2em]{
    \def\tablename{Table}
    \def\figurename{Fig.}
}

\captionsetup[bi-first]{bi-first}
\captionsetup[bi-second]{bi-second}
\captionsetup[table]{position=top,belowskip={12bp},aboveskip=0bp}
\captionsetup[figure]{position=bottom,belowskip={0bp},aboveskip=0bp}
\captionsetup[figure]{farskip=0pt}


% font size
\BeforeBeginEnvironment{tabular}{\xiaowu[1.3]\renewcommand\arraystretch{1.3}}
\BeforeBeginEnvironment{tabular*}{\xiaowu[1.3]\renewcommand\arraystretch{1.3}} % 2022-07-17 12:13:53
\BeforeBeginEnvironment{tblr}{\xiaowu[1.3]\renewcommand\arraystretch{1.3}} % 2022-09-16 20:51:54 fontsize


% Page setup
\RequirePackage{geometry}
\geometry{%
    twoside,
    bindingoffset=1cm,
    top=3cm,
    bottom=2cm,
    inner=2.5cm,
    outer=2.5cm,
    headsep=.5cm,
    footskip=.5cm,
    headheight=17pt,
    nomarginpar,
    ignoreall,
    showcrop,
    % showframe, % 2021-05-26
}	

\newcommand{\XAUAT@define@fontsize}[2]{%
    \expandafter\newcommand\csname #1\endcsname[1][1.3]{%
        \fontsize{#2}{##1\dimexpr #2}\selectfont}
}
\XAUAT@define@fontsize{chuhao}{42pt}
\XAUAT@define@fontsize{xiaochu}{36pt}
\XAUAT@define@fontsize{yihao}{26pt}
\XAUAT@define@fontsize{xiaoyi}{24pt}
\XAUAT@define@fontsize{erhao}{22pt}
\XAUAT@define@fontsize{xiaoer}{18pt}
\XAUAT@define@fontsize{sanhao}{16pt}
\XAUAT@define@fontsize{xiaosan}{15pt}
\XAUAT@define@fontsize{sihao}{14pt}
\XAUAT@define@fontsize{banxiaosi}{13pt}
\XAUAT@define@fontsize{xiaosi}{12pt}
\XAUAT@define@fontsize{dawu}{11pt}
\XAUAT@define@fontsize{wuhao}{10.5pt}
\XAUAT@define@fontsize{xiaowu}{9pt}
\XAUAT@define@fontsize{liuhao}{7.5pt}
\XAUAT@define@fontsize{xiaoliu}{6.5pt}
\XAUAT@define@fontsize{qihao}{5.5pt}
\XAUAT@define@fontsize{bahao}{5pt}

% fancyhdr
\RequirePackage{fancyhdr}
\fancypagestyle{XAUAT@empty}{%
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
}

\fancypagestyle{XAUAT@headings}{%
    \fancyhf{}
    \fancyhead[CO]{\songti\xiaosi[1.0]\leftmark}
    \fancyhead[CE]{\songti\xiaosi[1.0]\XAUAT@cschoolname\XAUAT@capply}
    \fancyfoot[RO,LE]{\songti\wuhao[1.0]\thepage}    
    \renewcommand{\headrule}{\hrule height 1.2pt \vspace{0.6mm}\hrule height 0.25pt} % headrule, reference: https://tex.stackexchange.com/questions/89569/custom-header-footer-rules-fancyhdr
    \renewcommand{\footrulewidth}{0pt}
}

\renewcommand\frontmatter{%
    \cleardoublepage
    \@mainmatterfalse
    \pagenumbering{Roman}
    \pagestyle{XAUAT@empty}
}

\renewcommand\mainmatter{%
    \cleardoublepage
    \@mainmattertrue
    \pagenumbering{arabic}
    \pagestyle{XAUAT@headings}
    \renewcommand\thesubsubsection{（\arabic{subsubsection}）}
    \renewcommand\theparagraph{\Roman{paragraph}} % set paragraph label as Roman
}

\renewcommand\backmatter{%
    \cleardoublepage
    \@mainmattertrue
}

% footmisc
\RequirePackage[perpage,hang,bottom]{footmisc} % 2021-11-16 21-37-44
\footnotemargin 0.5em\relax
\renewcommand{\footnoterule}{\vskip-3\p@\hrule\@width0.3\textwidth\@height0.4\p@\vskip2.6\p@}
\let\XAUAT@footnotesize\footnotesize
\renewcommand\footnotesize{\XAUAT@footnotesize\xiaowu}
% \renewcommand{\thefootnote}{\arabic{footnote}.~} % 2022-06-09 10:25:55 Adding dot after numbering


% enumerate footnotes with circled numbers % 2023-09-09 https://tex.stackexchange.com/questions/639370/how-to-enumerate-footnotes-with-circled-numbers
\tikzset{circlednode/.style={
    circle,
    draw,
    inner sep=0.05ex,
    text depth=0ex,
    font=\normalfont,
    minimum size=1ex
    }
}
\newcommand*\circled[1]{%
    \ifnumcomp{#1}{>}{9}{% 
    % if > 9:
    \tikz[baseline=(char.base)]\node[circlednode] (char) {\addfontfeature{LetterSpace=-9.0}\scalebox{0.5}[1]{\bfseries#1}};}{%
    % if <= 9: 
    \tikz[baseline=(char.base)]\node[circlednode] (char) {#1};}%
}
\renewcommand{\thefootnote}{%
    \raisebox{0.75ex}{%
    \scalebox{0.7}{\protect\circled{%
            \arabic{footnote}}%
        }%
    }%
}


% 标记样式
\let\XAUAT@makefnmark\@makefnmark
\newcommand{\XAUAT@@makefnmark}{\hbox{{\normalfont\@thefnmark}}}
\pretocmd{\@makefntext}{\let\@makefnmark\XAUAT@@makefnmark}{}{}
\apptocmd{\@makefntext}{\let\@makefnmark\XAUAT@makefnmark}{}{}

\renewcommand{\normalsize}{\fontsize{12pt}{22bp}\selectfont}
\setlength\jot{10pt}


\let\XAUAT@LT@array\LT@array
\renewcommand{\LT@array}{\wuhao[1.5]\XAUAT@LT@array}

\newcommand{\hlinewd}[1]{%
    \noalign{\ifnum0=`}\fi\hrule \@height #1 \futurelet
    \reserved@a\@xhline
}

% ctexset
\ctexset{%
    chapter={%
        afterindent=true,
        pagestyle=XAUAT@headings,
        beforeskip=0pt,%20.75bp \@plus 1ex \@minus .2ex,
        aftername=\hskip\ccwd,
        afterskip=10pt,%20.75bp \@plus .2ex,
        format=\centering,
        nameformat=\sanhao[1.5]\heiti,
        numberformat=\relax,
        titleformat=\sanhao[1.5]\heiti,
        lofskip=0pt,
        lotskip=0pt,
    },
    section={%
        afterindent=true,
        beforeskip=7pt,% \@plus 1ex \@minus .2ex,
        afterskip=2pt,% \@plus .2ex,
        aftername=\hskip\ccwd,
        format=\sihao[1.3]\heiti

    },
    subsection={%
        afterindent=true,           
        beforeskip=6pt,% \@plus 1ex \@minus .2ex,
        afterskip=0pt,% \@plus .2ex,
        aftername=\hskip\ccwd,
        format=\xiaosi[1.3]\songti\bfseries
    },
    subsubsection={%
        aftername=\relax,
        afterindent=true,
        % beforeskip=7.7bp \@plus 1ex \@minus .2ex,
        % afterskip=7.7bp \@plus .2ex,
        beforeskip=6pt,
        afterskip=0pt,
        format=\xiaosi[1.3]\songti\bfseries,
        indent=2\ccwd, % 2021-11-16 22:00:32
    },
    punct=quanjiao,
    space=auto,
    autoindent=true,
    linestretch=\ccwd,
}

% change paragraph style
\RequirePackage[indentafter]{titlesec}
\setcounter{secnumdepth}{4}
\titleformat{\paragraph}{\xiaosi[1.3]\songti\bfseries}{\theparagraph}{1ex}{}
\titlespacing*{\paragraph}{2em}{6bp}{0bp}


\newcounter{XAUAT@bookmark}
\NewDocumentCommand\XAUAT@chapter{s o m o}{%
    \IfBooleanF{#1}{%
        \ClassError{XAUATthesis}{You have to use the star form:
        \string\XAUAT@chapter*}{}
    }
    \clearpage
    \phantomsection
    \IfValueTF{#2}{% 若第一个o对应的可选参数没有提供，那么#2=-NoValue-,此判断为false
        \ifthenelse{\equal{#2}{}}{  % 第二个参数有，但为空，此 chapter 不出现在目录中
            \addtocounter{XAUAT@bookmark}\@ne
            \pdfbookmark[0]{#3}{XAUATchapter.\theXAUAT@bookmark}
        }
        { % 第二个参数有，且不为空，则将其加入目录
            \addcontentsline{toc}{chapter}{#3}
        }
    }
    { % 若没有指定该参数（即#2=-NoValue-），表示目录出现title
        \addcontentsline{toc}{chapter}{#3}
    }
    %
    \chapter*{#3}
    \IfValueTF{#4}{% 提供了第四个参数，即header
        \ifthenelse{\equal{#4}{}}
        { % 页眉为空
            \@mkboth{}{}
        }
        { % 页眉为提供的#4
            \thispagestyle{fancy}
            \pagestyle{XAUAT@headings}
            \fancyhf{}
            \fancyhead[CO]{\songti\xiaosi[1.0]#4}
            \fancyhead[CE]{\songti\xiaosi[1.0]\XAUAT@cschoolname\XAUAT@capply}
            \fancyfoot[RO,LE]{\songti\wuhao[1.0]\thepage}
        }
    }
    { % header 是页眉出现的标题，如果没有提供header参数，则取 title作为页眉
        \thispagestyle{fancy}
        \pagestyle{XAUAT@headings}
        \fancyhf{}
        \fancyhead[RO,LE]{\songti\xiaosi[1.0]#3}
        \fancyhead[CO]{\songti\xiaosi[1.0]#3}
        \fancyhead[CE]{\songti\xiaosi[1.0]\XAUAT@cschoolname\XAUAT@capply}
        \fancyfoot[RO,LE]{\songti\wuhao[1.0]\thepage}
    }
}

\RequirePackage{bm} % 2023-07-23


% ------------------------------------------------------------------------------
% main code
% ------------------------------------------------------------------------------
\AtBeginDocument{%
}

\newcommand{\XAUAT@def@term}[1]{%
    \define@key{XAUAT}{#1}{\csname #1\endcsname{##1}}
    \expandafter\gdef\csname #1\endcsname##1{%
        \expandafter\gdef\csname XAUAT@#1\endcsname{##1}
    }
    \csname #1\endcsname{}
}

% 论文中英文题目
\XAUAT@def@term{ctitlefirst}
\XAUAT@def@term{ctitlesecond}
\XAUAT@def@term{etitle}

% 作者、导师、副导师（校外）老师
\XAUAT@def@term{cauthor}
\XAUAT@def@term{eauthor}
\XAUAT@def@term{csupervisor}
\XAUAT@def@term{esupervisor}

% 学位中英文
\XAUAT@def@term{cdegree}
\XAUAT@def@term{cdegreebrief}
\XAUAT@def@term{edegree}

% 学位类别中英文
\XAUAT@def@term{cdegreetype}
\XAUAT@def@term{cdegreetypebrief}
\XAUAT@def@term{edegreetype}

% 院系中英文名称
\XAUAT@def@term{cdepartment}
\XAUAT@def@term{edepartment}

% 专业中英文名称
\XAUAT@def@term{cmajor}
\XAUAT@def@term{emajor}
\XAUAT@def@term{cmajortypetitle}

% 论文成文日期
\XAUAT@def@term{cdefencedate}
\XAUAT@def@term{edefencedate}

% 定义基金支持
\XAUAT@def@term{cfunds}
\XAUAT@def@term{efunds}

% 学号
\XAUAT@def@term{disciplineclassification}
\XAUAT@def@term{studentnumber}

% 论文类型
\XAUAT@def@term{cthesistype}
\XAUAT@def@term{ethesistype}

% 委员会
\XAUAT@def@term{committeeChairName}
\XAUAT@def@term{committeeChairTitle}
\XAUAT@def@term{committeeChairOri}
\XAUAT@def@term{committeeOneName}
\XAUAT@def@term{committeeOneTitle}
\XAUAT@def@term{committeeOneOri}
\XAUAT@def@term{committeeTwoName}
\XAUAT@def@term{committeeTwoTitle}
\XAUAT@def@term{committeeTwoOri}
\XAUAT@def@term{committeeThreeName}
\XAUAT@def@term{committeeThreeTitle}
\XAUAT@def@term{committeeThreeOri}
\XAUAT@def@term{committeeFourName}
\XAUAT@def@term{committeeFourTitle}
\XAUAT@def@term{committeeFourOri}
\XAUAT@def@term{committeeFiveName}
\XAUAT@def@term{committeeFiveTitle}
\XAUAT@def@term{committeeFiveOri}
\XAUAT@def@term{committeeSixName}
\XAUAT@def@term{committeeSixTitle}
\XAUAT@def@term{committeeSixOri}

\newcommand{\XAUATsetup}{\kvsetkeys{XAUAT}}
\RequirePackage{xeCJKfntef}
\newcommand{\XAUAT@underline}[2]{\CJKunderline{\hbox to #1{\hfill{#2}\hfill}}}

%华文行楷
\setCJKfamilyfont{stxingkai}{STXINGKA.TTF}
\newcommand{\stxingkai}{\CJKfamily{stxingkai}}

% 方正小标宋
\setCJKfamilyfont{fzxbsjw}{FZXBSJW.TTF}
\newcommand{\fzxbsjw}{\CJKfamily{fzxbsjw}}

%封面粗体字
\newcommand{\XAUAT@cover@font}{%
  \heiti\xiaosan}

%封面字段
\newcommand{\XAUAT@coverkey@font}{%
  \heiti\xiaosan}

% 封面第一页
\newcommand{\XAUAT@first@titlepage}
{
    % define color
    \definecolor{ColA}{cmyk}{0.05,0.07,0.09,0.00}
    \definecolor{ColB}{cmyk}{0.41,0.60,0.84,0.01}

    % newgeometry
    \newgeometry{margin=0mm} % bindingoffset=0mm, left=2cm, right=2cm,

    % tikz
    \begin{tikzpicture}[remember picture,overlay, shift={(current page.south west)}]
        % background
        \fill[ColA] rectangle(\paperwidth,\paperheight);
        \fill[ColB] (0.0,0.0) rectangle (20mm,\paperheight);

        % logo
        \node at (0.5\paperwidth,0.856\paperheight) {\includegraphics[width=7.1cm]{XAUAT_logo_1.png}};

        % classification
        \node at (0.84\paperwidth,0.94\paperheight) {
            \begin{tabular}{r@{}l}
                {\fzxbsjw\xiaosi\bfseries\XAUAT@classification} &
                \XAUAT@underline{6em}{\sihao\XAUAT@disciplineclassification}
            \end{tabular}
        };

        % dissertation
        \setlength{\parindent}{0pt}
        \node [color=ColB] at (0.5\paperwidth,0.763\paperheight) {
            \makebox[0.57\linewidth][s]{\fzxbsjw\chuhao[1]\XAUAT@capply}
        };

        % degreetype
        \node at (0.5\paperwidth,0.703\paperheight) {
            \fzxbsjw\sanhao\bfseries{（\XAUAT@cdegreetype）}
        };

        % title
        \node at (0.5\paperwidth,0.605\paperheight) {
            \parbox[c]{\textwidth}{\centering\sanhao\heiti\XAUAT@underline{21em}{\XAUAT@ctitlefirst}}
        };
        \node at (0.5\paperwidth,0.564\paperheight) {
            \parbox[c]{\textwidth}{\centering\sanhao\heiti\XAUAT@underline{21em}{\XAUAT@ctitlesecond}}
        };

        % details
        \node at (0.5\paperwidth,0.315\paperheight) {
            \begin{tblr}{width=0.7\paperwidth,columns={halign=c},rows={valign=m},colsep=0pt,rowsep=10pt,colspec={Q[r]Q[l]Q[l]}}
                \XAUAT@cover@font\makebox[4em][s]{\XAUAT@cauthortitle} & \XAUAT@cover@font{：} & \XAUAT@coverkey@font\XAUAT@underline{14em}{\XAUAT@cauthor} \\
                \XAUAT@cover@font\makebox[4em][s]{\XAUAT@cstudentnumbertitle} & \XAUAT@cover@font{：} & \XAUAT@coverkey@font\XAUAT@underline{14em}{\XAUAT@studentnumber} \\
                \XAUAT@cover@font\makebox[4em][s]{\XAUAT@cdepartmenttitle} & \XAUAT@cover@font{：} & \XAUAT@coverkey@font\XAUAT@underline{14em}{\XAUAT@cdepartment} \\
                \XAUAT@cover@font\makebox[4em][s]{\XAUAT@cmajortypetitle} & \XAUAT@cover@font{：} & \XAUAT@coverkey@font\XAUAT@underline{14em}{\XAUAT@cmajor} \\
                \XAUAT@cover@font\makebox[4em][s]{\XAUAT@csupervisortitle} & \XAUAT@cover@font{：} & \XAUAT@coverkey@font\XAUAT@underline{14em}{\XAUAT@csupervisor} \\
                \XAUAT@cover@font\makebox[4em][s]{\XAUAT@cdefencedatetitle} & \XAUAT@cover@font{：} & \XAUAT@coverkey@font\XAUAT@underline{14em}{\XAUAT@cdefencedate} \\
            \end{tblr}
        };


    \end{tikzpicture}
    \restoregeometry
} % end of titlepage

\newcommand{\XAUAT@second@titlepage}{% second page
    \begin{tikzpicture}[remember picture,overlay, shift={(current page.south west)}]

        % logo
        \node at (0.5\paperwidth,0.856\paperheight) {\includegraphics[width=7.1cm]{XAUAT_logo_1.png}};

        % dissertation
        \setlength{\parindent}{0pt}
        \node at (0.5\paperwidth,0.763\paperheight) {
            \makebox[0.57\linewidth][s]{\fzxbsjw\chuhao[1]\XAUAT@capply}
        };

        % degreetype
        \node at (0.5\paperwidth,0.703\paperheight) {
            \fzxbsjw\sanhao\bfseries{（\XAUAT@cdegreetype）}
        };

        % title
        \node at (0.5\paperwidth,0.605\paperheight) {
            \parbox[c]{\textwidth}{\centering\sanhao\heiti\XAUAT@underline{21em}{\XAUAT@ctitlefirst}}
        };
        \node at (0.5\paperwidth,0.564\paperheight) {
            \parbox[c]{\textwidth}{\centering\sanhao\heiti\XAUAT@underline{21em}{\XAUAT@ctitlesecond}}
        };

        % details
        \node at (0.5\paperwidth,0.315\paperheight) {
            \begin{tblr}{width=0.7\paperwidth,columns={halign=c},rows={valign=m},colsep=0pt,rowsep=10pt,colspec={Q[r]Q[l]Q[l]}}
                \XAUAT@cover@font\makebox[4em][s]{\XAUAT@cauthortitle} & \XAUAT@cover@font{：} & \XAUAT@coverkey@font\XAUAT@underline{14em}{\XAUAT@cauthor} \\
                \XAUAT@cover@font\makebox[4em][s]{\XAUAT@cstudentnumbertitle} & \XAUAT@cover@font{：} & \XAUAT@coverkey@font\XAUAT@underline{14em}{\XAUAT@studentnumber} \\
                \XAUAT@cover@font\makebox[4em][s]{\XAUAT@cdepartmenttitle} & \XAUAT@cover@font{：} & \XAUAT@coverkey@font\XAUAT@underline{14em}{\XAUAT@cdepartment} \\
                \XAUAT@cover@font\makebox[4em][s]{\XAUAT@cmajortypetitle} & \XAUAT@cover@font{：} & \XAUAT@coverkey@font\XAUAT@underline{14em}{\XAUAT@cmajor} \\
                \XAUAT@cover@font\makebox[4em][s]{\XAUAT@csupervisortitle} & \XAUAT@cover@font{：} & \XAUAT@coverkey@font\XAUAT@underline{14em}{\XAUAT@csupervisor} \\
                \XAUAT@cover@font\makebox[4em][s]{\XAUAT@cdefencedatetitle} & \XAUAT@cover@font{：} & \XAUAT@coverkey@font\XAUAT@underline{14em}{\XAUAT@cdefencedate} \\
            \end{tblr}
        };
    \end{tikzpicture}
    % \restoregeometry
}

\newcommand{\engcover}
{%
    \singlespacing
    \begin{center}
        \vspace*{1cm}
        \erhao[1.3]{\bfseries\XAUAT@etitle}
        \vskip 126pt
        
        \sihao[2.0]{\XAUAT@eapply\\\XAUAT@edegree }
        \vskip 120pt

        {
        % \begin{tblr}{colspec={Q[l]Q[l]},rows={font=\xiaosi},colsep=0pt,rowsep=4pt}
        %         Candidate:~         & \XAUAT@eauthor       \\
        %         Student Number:~    & \XAUAT@studentnumber \\
        %         School/Department:~ & \XAUAT@edepartment   \\
        %         Major:~             & \XAUAT@emajor \\
        %         Supervisor:~        & \XAUAT@esupervisor \\
        %         Defence date:~        & \XAUAT@edefencedate \\
        % \end{tblr}
        \sihao[2.0]{
            By\\
            \XAUAT@eauthor\\
            Supervisor:~\XAUAT@esupervisor\\
            \XAUAT@emajor\\
            \XAUAT@edefencedate
        }
        }
    \end{center}
} % end of english cover

\newcommand{\committee}{
    \addtocounter{XAUAT@bookmark}\@ne
    \pdfbookmark[0]{\XAUAT@committee}{XAUATchapter.\theXAUAT@bookmark}
    \pagestyle{XAUAT@headings}
    \fancyhf{}
    \fancyhead[CO]{\songti\xiaosi[1.0]\XAUAT@committee}
    \fancyhead[CE]{\songti\xiaosi[1.0]\XAUAT@cschoolname\XAUAT@capply}
    %
    \begin{center}
    \vspace*{1em}
    {\heiti\erhao[1.3] \XAUAT@cdegree\XAUAT@committee}\\
    \vspace{2cm}
    % {\xiaoer[1.3]{\heiti\XAUAT@ctitlefirst\XAUAT@ctitlesecond}}
    \parbox[c]{0.75\linewidth}{\heiti\xiaoer[1.5]\centering\XAUAT@ctitlefirst \XAUAT@ctitlesecond}
    
    \vspace{4cm}
    
    \begin{tblr}{colspec={|X|X|X|X[5cm]|},rows={valign=m,font=\heiti\xiaosi},columns={halign=c},stretch=2.2}
        \hline
        \XAUAT@defenceAuthorTitle & \SetCell[c=3]{c} \XAUAT@cauthor & & \\\hline
        \XAUAT@defenceTimeTitle  & \SetCell[c=3]{c} \XAUAT@cdefencedate & & \\\hline
        \XAUAT@defenceCommitteeTitle & \XAUAT@committeeNameTitle & \XAUAT@committeeTitleTitle & \XAUAT@committeeOrgTitle \\\hline
        \XAUAT@committeeCChairTitle & \XAUAT@committeeChairName & \XAUAT@committeeChairTitle & \XAUAT@committeeChairOri\\ \hline
        \SetCell[r=6]{m} \XAUAT@committeeTitle & \XAUAT@committeeOneName & \XAUAT@committeeOneTitle & \XAUAT@committeeOneOri \\ \hline
         & \XAUAT@committeeTwoName & \XAUAT@committeeTwoTitle & \XAUAT@committeeTwoOri \\ \hline
         & \XAUAT@committeeThreeName & \XAUAT@committeeThreeTitle & \XAUAT@committeeThreeOri \\ \hline
         & \XAUAT@committeeFourName & \XAUAT@committeeFourTitle & \XAUAT@committeeFourOri \\ \hline
         & \XAUAT@committeeFiveName & \XAUAT@committeeFiveTitle & \XAUAT@committeeFiveOri \\ \hline
         & \XAUAT@committeeSixName & \XAUAT@committeeSixTitle & \XAUAT@committeeSixOri \\ \hline
    \end{tblr}
    \end{center}
}

\newcommand{\declaration}{
    \addtocounter{XAUAT@bookmark}\@ne
    \pdfbookmark[0]{\XAUAT@declaration}{XAUATchapter.\theXAUAT@bookmark}
    \pagestyle{XAUAT@headings}
    \fancyhf{}
    \fancyhead[CO]{\songti\xiaosi[1.0]\XAUAT@declaration}
    \fancyhead[CE]{\songti\xiaosi[1.0]\XAUAT@cschoolname\XAUAT@capply}
    %
    \normalsize
    \begin{center}  
        {\vspace*{1em}\songti\xiaoer[1]\XAUAT@declarationtitle}
        \begin{flushleft}
            {\XAUAT@declarationtext\\
            \vskip12pt
            \hspace*{2em}\XAUAT@authorsignaturetitle \hspace*{10em}\XAUAT@datetitle}
        \end{flushleft}
        \vskip48pt
        {\centering\songti\xiaoer\XAUAT@authorization}
        \begin{flushleft}
            {\hspace*{2em}\XAUAT@authorizationtext\\\vskip12pt
            \hspace*{2em}\XAUAT@authorsignaturetitle \hspace*{10em}\XAUAT@datetitle
            }\\\vskip12pt
            {
            \hspace*{2em}\XAUAT@supervisorsignature\hspace*{10em}\XAUAT@datetitle}
        \end{flushleft}
    \end{center}
}

% 摘要
\newcommand{\XAUAT@@cabstract}[1]{\long\gdef\XAUAT@cabstract{#1}}
\newenvironment{cabstract}{\Collect@Body\XAUAT@@cabstract}{}
\newcommand{\XAUAT@@eabstract}[1]{\long\gdef\XAUAT@eabstract{#1}}
\newenvironment{eabstract}{\Collect@Body\XAUAT@@eabstract}{}
\newcommand{\XAUAT@parse@keywords}[1]{
    \define@key{XAUAT}{#1}{\csname #1\endcsname{##1}}
    \expandafter\gdef\csname XAUAT@#1\endcsname{}
    \expandafter\gdef\csname #1\endcsname##1{
        \@for\reserved@a:=##1\do{
            \expandafter\ifx\csname XAUAT@#1\endcsname\@empty\else
            \expandafter\g@addto@macro\csname XAUAT@#1\endcsname{%
            \ignorespaces\csname XAUAT@#1@separator\endcsname}
            \fi
            \expandafter\expandafter\expandafter\g@addto@macro%
            \expandafter\csname XAUAT@#1\expandafter\endcsname\expandafter{\reserved@a}
        }
    }
}
\XAUAT@parse@keywords{ckeywords}
\XAUAT@parse@keywords{ekeywords}

% CN & EN
\newcommand{\XAUAT@makeabstract}{%
    \cleardoublepage
    \phantomsection
    \addcontentsline{toc}{chapter}{\cabstractname}
    % \addtocounter{XAUAT@bookmark}\@ne
    % \pdfbookmark[0]{\cabstractname}{XAUATchapter.\theXAUAT@bookmark}
    \pagestyle{XAUAT@headings}
    \fancyhf{}
    \fancyhead[CO]{\songti\xiaosi[1.0]\cabstractname}
    \fancyhead[CE]{\songti\xiaosi[1.0]\XAUAT@cschoolname\XAUAT@capply}
    \fancyfoot[RO,LE]{\songti\wuhao[1.0]\thepage}
    \setcounter{page}{1}
    
    % \setCJKfamilyfont{fzxbsjw}{FZXBSJW.TTF}
    {\noindent\centering
    \parbox[c]{0.9\linewidth}{\CJKfamily{fzxbsjw}\sanhao[1.5]\centering\XAUAT@ctitlefirst \\ \XAUAT@ctitlesecond\ifthenelse{\equal{\XAUAT@cfunds}{}}{}{$^{\ast}$}}\par % 
    \vspace{9pt}
    {
    \centering
    \begin{tblr}{colspec={Q[r]Q[l]Q[l]},rows={font=\xiaosi\kaishu},colsep=0pt,rowsep=4pt}
        \XAUAT@cdegreetype@title                                       &：&  \XAUAT@cdegreetype \\
        \XAUAT@cmajorname                                  &：& \XAUAT@cmajor
    \end{tblr}
    }
    \vspace{16pt} \par
    \sanhao[1.0]\heiti\cabstractname
    \vspace{8pt}
    \par
    }
    \XAUAT@cabstract
    \par\vspace{12pt}
    \setbox0=\hbox{{\bfseries\heiti\XAUAT@ckeywords@title}}
    \noindent\hangindent\wd0\hangafter1
    \box0\XAUAT@ckeywords
    \par
    \vskip 9bp 
    \hbox{{\bfseries\heiti\XAUAT@cthesistype@title}{\XAUAT@cthesistype}}
    \vskip 20bp 
    \ifthenelse{\equal{\XAUAT@cfunds}{}}{}
    {
        \noindent
        \parbox[c]{\linewidth}{\hangindent 1em\songti\bfseries$\ast$\XAUAT@cfunds}
    }
    %
    \cleardoublepage
    \phantomsection
    \addcontentsline{toc}{chapter}{\eabstractname}
    % \addtocounter{XAUAT@bookmark}\@ne
    % \pdfbookmark[0]{\eabstractname}{XAUATchapter.\theXAUAT@bookmark}
    \pagestyle{XAUAT@headings}
    \fancyhf{}
    \fancyhead[CO]{\songti\xiaosi[1.0]\eabstractname}
    \fancyhead[CE]{\songti\xiaosi[1.0]\XAUAT@cschoolname\XAUAT@capply}
    \fancyfoot[RO,LE]{\songti\wuhao[1.0]\thepage}
    % \vspace*{20.8pt}
    {\noindent\centering
    \parbox[c]{1\linewidth}{\sanhao[1.3]\bfseries\centering\XAUAT@etitle\ifthenelse{\equal{\XAUAT@efunds}{}}{}{$^{\ast}$}}\par
    \vspace{9pt}
    {
    \centering
    \begin{tblr}{colspec={Q[r]Q[l]Q[l]},rows={font=\xiaosi},colsep=0pt,rowsep=4pt}
        {\bf \XAUAT@edegreetype@title}       &:&  {\hspace{.5em}}\XAUAT@edegreetype \\
        {\bf\XAUAT@emajorname}       &:&  {\hspace{.5em}}\XAUAT@emajor \\
    \end{tblr}
    }
    \vspace{16pt} \par
    \sanhao[1.0]\bfseries\eabstractname
    \vspace{8pt}
    \par
    }
    \XAUAT@eabstract
    \par\vspace{8pt}
    \setbox0=\hbox{{\bfseries Keywords:\enskip}}
    \noindent\hangindent\wd0\hangafter1
    \box0\XAUAT@ekeywords
    \par
    \vskip 9bp 
    \hbox{{\bfseries\XAUAT@ethesistype@title}{\XAUAT@ethesistype}}
    \vskip 20bp 
    \ifthenelse{\equal{\XAUAT@efunds}{}}{}
    {
        \noindent
        \edef\prevhbadness{\the\hbadness}\hbadness=2600 % might occur underfull warning, increase the hbadness to 2600
        \parbox[c]{\linewidth}{\hangindent 1em\bfseries$\ast$\hspace{0.5em}\XAUAT@efunds}
        \hbadness=\prevhbadness\relax % recover previous hbadness
    }
}

% 生成封面总命令
\newcommand{\makecover}{%
    \phantomsection
    \pdfbookmark[-1]{\XAUAT@ctitlefirst \XAUAT@ctitlesecond}{ctitle}
    \normalsize
    \begin{titlepage}
        \XAUAT@first@titlepage
        \cleardoublepage
        \XAUAT@second@titlepage
        \cleardoublepage
        \engcover
        \cleardoublepage
        \committee
        \cleardoublepage
        \declaration
    \end{titlepage}
    \normalsize
    \XAUAT@makeabstract
}

% table of content
\renewcommand\tableofcontents{
    \XAUAT@chapter*[]{\contentsname}[\contentsname] % 
    \normalsize\@starttoc{toc}\clearpage
}

\setcounter{tocdepth}{2}
% \setcounter{secnumdepth}{4}

\RequirePackage{titletoc}
\contentsmargin{1.5em}
\titlecontents{chapter}
                [0em]
                {\filright\bf}
                {\thecontentslabel\enspace}
                {}
                {\dotfill\contentspage\hspace*{0cm}}
\titlecontents{section}
                [1em]
                {\addvspace{0pt}}
                {\thecontentslabel\enspace}
                {}
                {\dotfill\contentspage\hspace*{0cm}}
\titlecontents{subsection}
                [2em]
                {\addvspace{0pt}}
                {\thecontentslabel\enspace}
                {}
                {\dotfill\contentspage\hspace*{0cm}}     % \titlerule*[0.3pc]{$\cdot$}

% 主要符号对照表
\newenvironment{denotation}[1][2.5cm]{%
    \XAUAT@chapter*{\XAUAT@denotation@name}[\XAUAT@denotation@name] % 
    \vskip-30bp
    \normalsize
    \begin{XAUAT@denotation}[labelwidth=#1]
}
{%
    \end{XAUAT@denotation}
    \clearpage
}
\newlist{XAUAT@denotation}{description}{1}
\setlist[XAUAT@denotation]{%
    nosep,
    font=\normalfont,
    align=left,
    leftmargin=!, % sum of the following 3 lengths
    labelindent=0pt,
    labelwidth=2.5cm,
    labelsep*=0.5cm,
    itemindent=0pt,
}

% 致谢以及声明
\NewDocumentEnvironment{acknowledgement}{}{%
    \XAUAT@chapter*[\XAUAT@ackname]{\XAUAT@ackname}[\XAUAT@ackname] % 
    \normalsize
}{\clearpage}

% 参考文献
\let\inlinecite\parencite
\setlength{\bibitemsep}{0ex}
\setlength{\bibnamesep}{0ex}
\setlength{\bibinitsep}{0ex}
\setlength{\biblabelsep}{\labelsep}
\newcommand\printXAUATbibliography{\begingroup\setstretch{1.0}\printbibliography[heading=bibintoc]\clearpage\sloppy\endgroup % 解决行溢出
}


% 图表索引
% 定义图表以及公式目录样式
\newcommand{\XAUAT@starttoc}[1]{% #1: float type, prepend type name in \listof*** entry.
    \let\oldnumberline\numberline
    \def\numberline##1{\oldnumberline{\csname #1name\endcsname\hskip.4em ##1}}
    \@starttoc{\csname ext@#1\endcsname}
    \let\numberline\oldnumberline}  
    \newcommand{\XAUAT@listof}[1]{% #1: float type
    \@ifstar
    {%带星的不加入目录，如\listoftables*
        \XAUAT@chapter*[]{\csname list#1name\endcsname}[\csname list#1name\endcsname] % 
        \XAUAT@starttoc{#1}
        \clearpage}
    {%加入目录
        \XAUAT@chapter*{\csname list#1name\endcsname}[\csname list#1name\endcsname] % 
        \XAUAT@starttoc{#1}
        \clearpage}
    }
\renewcommand\listoffigures{\XAUAT@listof{figure}}
\renewcommand*\l@figure{\@dottedtocline{1}{0em}{4em}}
\renewcommand{\@dotsep}{2}              %改变索引中点间距
\renewcommand\listoftables{\XAUAT@listof{table}}
\let\l@table\l@figure

% 附录
\fancypagestyle{XAUAT@appendix@heading}{%
    \fancyhead{}
    \fancyhead[C]{\songti\xiaosi[1]\appendixname} % \XAUAT@cschoolname\XAUAT@capply~
    \fancyfoot{}
    \fancyfoot[RO,LE]{\songti\wuhao[1]\thepage}
    \renewcommand{\headrule}{\hrule height 1pt \vspace{.5mm}\hrule height 0.25pt}
    \renewcommand{\footrulewidth}{0pt}
}
\let\XAUAT@appendix\appendix
\renewenvironment{appendix}{% 
    \ctexset{
    chapter/pagestyle={XAUAT@appendix@heading}
    } 
    \pagestyle{XAUAT@appendix@heading}
    \let\title\XAUAT@appendix@title
    \XAUAT@appendix
}
{\let\title\@gobble  \clearpage}

% 个人简历
\newenvironment{resume}{%
    \XAUAT@chapter*{\XAUAT@resume@title}[\wuhao\songti\XAUAT@resume@title] % 
    \wuhao[1.5] 
    \setlist[enumerate,1]{leftmargin=2em}   %设置enumerate左间隙距离
}{\clearpage}
\newcommand{\resumeitem}[1]{\vspace{2.5em}{\bfseries\wuhao\heiti\leftline{#1}}\par}


\AtEndOfClass{\input{XAUATthesis.cfg}}
\endinput