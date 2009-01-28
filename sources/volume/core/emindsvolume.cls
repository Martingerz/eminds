
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{emindsvolume}[2005/03/24 Eminds volume class]
%------------------------------------------------------------------------------------
\LoadClass{emindspaper}

%------------------------------------------------------------------------------------
%Chapter command
\newcounter {chapter}
\renewcommand\thechapter      {\@arabic\c@chapter}
\newcommand\chapter{\clearpage
                    \thispagestyle{empty}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                  {\protect\numberline{\thechapter}#1}%
                       \else
                         \addcontentsline{toc}{chapter}{#1}%
                       \fi
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}
\def\@makechapterhead#1{%
% \vspace*{50\p@}%
  {\centering
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        \large\bfseries \@chapapp{} \thechapter
        \par\nobreak
        \vskip 20\p@
      \fi
    \fi
    \interlinepenalty\@M
    \LARGE \bfseries #1\par\nobreak
    \vskip 40\p@
  }}
\def\@schapter#1{\if@twocolumn
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                   \@makeschapterhead{#1}%
                   \@afterheading
                 \fi}
\def\@makeschapterhead#1{%
% \vspace*{50\p@}%
  {\centering
    \normalfont
    \interlinepenalty\@M
    \LARGE \bfseries  #1\par\nobreak
    \vskip 40\p@
  }}
  
%------------------------------------------------------------------------------------
\RequirePackage{multicols}
  
%------------------------------------------------------------------------------------
\refstepcounter{part}  

%For the entries of the kind title/content in the volume primer
\newcommand{\volumeEntry}[2]{%
\noindent \textbf{#1} \\
{#2}\\
\vspace{5mm}%
}
\newcommand{\volumeEntryNoSkip}[2]{
\noindent \textbf{#1} \\
{#2}\\
}



\def\contentsname{Table of Contents}

%Table of contents (redefined to use a chapter title)
\makeatletter
\renewcommand\tableofcontents{%
    \chapter*{\contentsname
        \@mkboth{%
           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \@starttoc{toc}%
    }
\makeatother

%First part of the volume (primer)
%Roman numbers
\newcommand{\frontmatter}{
\renewcommand{\thepage}{\roman{page}}
\setcounter{page}{1}
\pagestyle{plain}
}

%Contents of the volume (papers)
%Arabic numbers
\newcommand{\mainmatter}{
\renewcommand{\thepage}{\arabic{page}}
\setcounter{page}{1}
\pagestyle{fancy}
}

\setcounter{tocdepth}{0}

% left bottom right top
\newcommand{\insertOddAdvert}[1]{%
\includepdf[fitpaper=false, trim=3cm -1.1cm 4cm -1.1cm]{#1}}

\newcommand{\insertEvenAdvert}[1]{%
\includepdf[fitpaper=false, trim=4cm -1.1cm 3cm -1.1cm]{#1}}

\newcommand{\emindSubtitle}[1]{\noindent\textbf{{\Large{#1}}}\vspace*{5mm}}

\newcommand{\insertAdvert}[1]{%Ojo al par/impar: es al contrario porque includepdf genera nueva página
\ifthenelse{\isodd\thepage}%
{\insertEvenAdvert{#1}}%
{\insertOddAdvert{#1}}%
}


% \newcommand{\insertAdvert}[1]{\newpage\includepdf[fitpaper=false, trim=1.2cm -6cm -4cm 0]{#1}}

% \marginsize{3.3cm}{1.1cm}{1.1cm}{1.1cm}
% \marginsize{7.60cm}{1.20cm}{1.2cm}{6.90cm}

\newcommand{\inputPaper}[2][]{
\cleardoublepage
\renewcommand{\paperAuthor}{}%
\renewcommand{\authorString}{}%
\renewcommand{\instituteString}{}%
\renewcommand{\abbreviatedHeader}{false}%
\renewcommand{\firstAuthor}{}%
\renewcommand{\headerAuthorString}{\paperAuthor}

\graphicspath{{#2/}}
\input{#2/paper}

\ifthenelse{\equal{#1}{}}% Publicidad al final, es opcional
{}%
{\insertAdvert{#1}}

}


\newcommand{\startSpecialSection}{%
\cleardoublepage
\input{volume-special-contributions-cover}%
%\addcontentsline{toc}{section}{Usability Reports}
\cleardoublepage
}

%Empty blank pages
\makeatletter
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
  \hbox{}
  \vspace*{\fill}
  \vspace{\fill}
  \thispagestyle{empty}
  \newpage
  \if@twocolumn\hbox{}\newpage\fi\fi\fi}
\makeatother

%Figure captions space
\addtolength{\abovecaptionskip}{-12pt}
\addtolength{\headsep}{-12pt}

\endinput
