
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{emindspaper}[2005/03/17 Eminds paper class]
%------------------------------------------------------------------------------------
\LoadClass[onecolumn,twoside,a4paper,10pt]{article}

%------------------------------------------------------------------------------------
\RequirePackage{anysize} % To use the command \marginsize
\RequirePackage[latin1]{inputenc} %To show spanish characters
\RequirePackage{fancyhdr}
\RequirePackage{ifthen}
\RequirePackage[pdftex]{color,graphicx}

%Comment this line for A4 paper size (uncommented for LULU)
\RequirePackage[papersize={156mm,234mm}]{geometry}

%\RequirePackage[pdftex]{hyperref}


%------------------------------------------------------------------------------------

%Margins
%{/margen_izq/}{/margen_dch/}{/margen_sup/}{/margen_inf/}
% \marginsize{7.60cm}{1.20cm}{1.2cm}{6.90cm}
%Le quito 6 mm a la cabecera según recomendación de martín
\marginsize{3.3cm}{1.1cm}{0.5cm}{1.1cm}%El inferior era 1.1cm

%Abstract section
\renewenvironment{abstract}{%
      \list{}{\advance\topsep by0.35cm\relax\small
      \leftmargin=1cm
      \labelwidth=\z@
      \listparindent=\z@
      \itemindent\listparindent
      \rightmargin\leftmargin}\item[\hskip\labelsep
                                    \bfseries\abstractname]
			}
    {\endlist}

%Symbols of the itemize environment
\renewcommand\labelitemi{\normalfont\bfseries --}
\renewcommand\labelitemii{$\m@th\bullet$}

\date{}

%------------------------------------------------------------------------------------
%from the patchcmd.sty package
\newcommand{\patchcommand}[1]{%
  \expandafter\patchcmd@a\meaning#1??->@\@nil#1%
}
\long\def\patchcmd@a#1#2#3->#4#5\@nil#6{%
%%  \wrs{\string#6: [#1] [#2] [#3]->[#4]}%
  \ifx @#4\relax \patchcmdError#6#1%
    \expandafter\@gobbletwo % discard the other two arguments
  \else
    \if l#2\toks@{\patchcmd@e{}#6}% l in this position means \long
    \else \toks@{\patchcmd@e*#6}%   not \long
    \fi
    \patchcmd@b #3@#4#5 ? ? ? \@nil#6%
    \expandafter\the\expandafter\toks@
  \fi
}
\def\patchcmd@b#1:#2@#3#4 #5#6 #7 #8\@nil#9{%
%%  \wrs{[#1] [#2] [#3] [#4] [#5] [#6] ARG7=[#7] [#8]}%
  \if \ifx @#7@\expandafter
      \ifx\csname #6\endcsname#9T\else F\fi\else F\fi T%
    \toks@\expandafter{\expandafter\patchcommand\csname #6 \endcsname}%
  \else
    \ifx @#2@% No arguments
      \toks@\expandafter{\the\toks@ 0}%
    \else
      \patchcmd@c 0#2{\string##}0%
    \fi
  \fi
}
\def\patchcmd@c#1#2#3{%
  \if\string###2%      % yes it's a # token
    \ifodd 0#31 % and it's followed by a number
      \if 0#3\patchcmd@d#1\fi % number=0? then we're done
    \else \patchcmd@d D% # not a number: must be a delimited arg
    \fi
  \else \patchcmd@d D% not a # token: must be a delmited arg
  \fi
  \patchcmd@c#3%
}
\def\patchcmd@d#1{%
  \if D#1%
    \PackageError{patchcmd}{Cannot change a macro that has
      delimited arguments}\@ehd
  \else
    \toks@\expandafter{\the\toks@ #1}%
  \fi
  \begingroup
  \aftergroup\@gobble
  \let\patchcmd@c\endgroup
}
\def\patchcmd@e#1#2#3#4#5{%
  \begingroup
  \edef\@##1{%
    \@temptokena\noexpand\expandafter{%
      \noexpand#2%
        \ifnum#3>0 {####1}\ifnum#3>1 {####2}\ifnum#3>2 {####3}%
        \ifnum#3>3 {####4}\ifnum#3>4 {####5}\ifnum#3>5 {####6}%
        \ifnum#3>6 {####7}\ifnum#3>7 {####8}\ifnum#3>8 {####9}%
        \fi\fi\fi\fi\fi\fi\fi\fi\fi
      ##1%
    }%
  }
  \@{#5}%
  \edef\@##1{\endgroup
    \noexpand\renewcommand#1\noexpand#2\ifcase#3 \else [#3]\fi
    {##1\the\@temptokena}}%
  \@{#4}%
%%  \show#2%
}
\long\def\patchcmdError#1#2{%
  \begingroup
  \toks@{Not redefinable}%
  \ifcat\relax\noexpand#1% Is it a control sequence?
    \begingroup
    \let#1=?\ifx ?\relax % Is it "\relax"?
      \endgroup % accept current value of \toks@
    \else \endgroup
      \if\ifx\relax#1u\else #2\fi u%
        \toks@{Not defined}%
      \fi
    \fi
  \fi
  \edef\@{\endgroup
    \noexpand\PackageError{patchcmd}{%
      \the\toks@: \string#1}\noexpand\@ehd}%
  \@
}
%\endinput



%------------------------------------------------------------------------------------
\newcommand{\authorString}{}
\newcommand{\instituteString}{}
\newcommand{\firstAuthor}{}

%Set one author. Receives group index (optional) and author name
\newcommand{\setAuthor}[2][]{%
	\ifthenelse {\equal {\firstAuthor} {}}
	{\renewcommand{\firstAuthor}{#2}}
	{}

   	\ifthenelse {\equal {\paperAuthor} {} }
   	{\patchcommand\paperAuthor{}{#2}}
   	{\patchcommand\paperAuthor{}{, #2}}
	
  	\ifthenelse {\equal {\authorString} {} }
    	{\patchcommand\authorString{}{\authorEntry{#2}}}
     	{\patchcommand\authorString{}{, \authorEntry{#2}}}

	\ifthenelse{\equal{#1}{}}{}{\patchcommand\authorString{}{\ensuremath{^{#1}}}}
		
	\author{\authorString}
}


%To display an author entry, receives name
\newcommand{\authorEntry}[1]{%
#1%
}

%Set one group. Receives institute index (optional) and institute name
\newcommand{\setInstitute}[2][]{
	\ifthenelse{\equal{#1}{}}{%
  	\ifthenelse {\equal {\instituteString} {} }%
    	{\patchcommand\instituteString{}{#2}}%
     	{\patchcommand\instituteString{}{\\ \medskip #2}}%
	}
	{\ifthenelse {\equal {\instituteString}{}}%
		{\patchcommand\instituteString{}{\ensuremath{^{#1}} #2}}%
		{\patchcommand\instituteString{}{\\ \medskip \ensuremath{^{#1}} #2}}%
	}
	\date{\instituteString}
}




%Maketitle redefinition (to can have more than one title and to add entries into the TOC)
%------------------------------------------------------------------------------------
\newcommand{\paperAuthor}{}
\newcommand{\paperTitle}{No title} 

% \def\@maketitle{%
%   \newpage
%   \null
%   \vskip 2em%
%   \begin{center}%
%   \let \footnote \thanks
%     {\LARGE \@title \par}%
%     \vskip 1.5em%
%     {\large
%       \lineskip .5em%
%       \begin{tabular}[t]{c}%
%         \@author
%       \end{tabular}\par}%
%     \vskip 1em%
%     {\large \@date}%
%   \end{center}%
%   \par
%   \vskip 1.5em
% }

\def\@maketitle{%
  \newpage
  % \null%
  % \vskip 2em%
  \begin{center}%
  \let \footnote \thanks
    {\LARGE \@title \par}%
    \vskip 1.5em%
    {\normalsize
      \lineskip .5em%
%      \begin{tabular}[t]{c}%
        \@author\par}
%      \end{tabular}\par}%
    \vskip 1em%
    {\small \@date}%
  \end{center}%
  \par
  \smallskip
}

\newcommand{\ORGORGmaketitle}{}
\let\ORGORGmaketitle\maketitle
\makeatletter
\def\maketitle{%
	\clearpage
	
%	\refstepcounter{chapter}%
	\refstepcounter{section}%
	\setcounter{section}{0}%
	\setcounter{subsection}{0}%
	\setcounter{figure}{0}
	\setcounter{table}{0}
	\setcounter{equation}{0}
	\setcounter{footnote}{0}%
	\setcounter{lstlisting}{0}
	
	
	\let\ORG@title\@title
	\let\ORG@author\@author
	\let\ORG@date\@date
	\let\ORG@thanks\@thanks
	\let\ORG@maketitle\@maketitle
	\let\ORGtitle\title
	\let\ORGauthor\author
	\let\ORGdate\date
	\let\ORGthanks\thanks
	\let\ORGmaketitle\maketitle
	\let\ORGand\and
	\ORGORGmaketitle
	\global\let\@title\ORG@title
	\global\let\@author\ORG@author
	\global\let\@date\ORG@date
	\global\let\@thanks\ORG@thanks
	\global\let\@maketitle\ORG@maketitle
	\global\let\title\ORGtitle
	\global\let\author\ORGauthor
	\global\let\date\ORGdate
	\global\let\thanks\ORGthanks
	\global\let\maketitle\ORGmaketitle
	\global\let\and\ORGand
	
	\addcontentsline{toc}{part}{\ORG@title\\
	\normalfont{\small{\paperAuthor}}}
	% \addtocontents{toc}{\paperAuthor\par}
	
% 	\renewcommand{\paperAuthor}{\ORG@author}
 	\renewcommand{\paperTitle}{\ORG@title}

	%Para la primera pagina de los papers
	 \fancypagestyle{plain}{
		\fancyfoot[OC]{\footnotesize \firsPagePaperReference}
		\fancyfoot[OR]{}
		\fancyfoot[OL]{}
		\fancyhead{}
		\renewcommand{\headrulewidth}{0pt} 
	 }	
	
	\thispagestyle{plain}
}
\makeatother

%------------------------------------------------------------------------------------
%Headers and foots
\newcommand{\abbreviatedHeader}{false}
\newcommand{\setAbbreviatedHeader}[1]{\renewcommand{\abbreviatedHeader}{#1}}
\newcommand{\headerAuthorString}{\paperAuthor}



%The special first page signature is only showed in the volume compilation
\ifdefined\thisIsAeMindsVolume
\newcommand{\firsPagePaperReference}{\paperAuthor\ ``\paperTitle'' Vol. \emindsVolumeCount\ No. \emindsVolumeNumber\ (\emindsVolumeDate). ISSN: \emindsISSNprinted\ (print) - \emindsISSNonline\ (online). \texttt{\emindsHomePage}}
\else
\newcommand{\firsPagePaperReference}{}
\fi




\newcommand{\headerAuthorCommand}{%
\ifthenelse{\equal {\abbreviatedHeader}{true}}%
{\firstAuthor\ et al.}%
{\headerAuthorString}}%

\fancyhf{}
% Arriba:  Título  del  paper  (impares)  y autores (pares) en negrita y
% alineado al exterior.
\setlength{\headheight}{23pt}
%\setlength{\footskip}{0.5cm} %Pruebas con margen inferior menor
\fancyfoot[OR, EL] {\thepage}
\fancyhead[OR] {\textbf{\paperTitle}}
\fancyhead[EL] {\textbf{\headerAuthorCommand}}
% \fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0pt}

\pagestyle{fancy}




%------------------------------------------------------------------------------------
\newcommand{\eminds}{e-Minds}
%------------------------------------------------------------------------------------
\newcommand{\todo}[1]{{\color{red}{#1}}}

%------------------------------------------------------------------------------------
%\newcommand{\email}[1]{{\texttt{#1}}}
\newcommand{\email}[2]{\texttt{#1 AT #2}}
%\newcommand{\emailcommand}[2]{\email{#1 AT #2}}
%------------------------------------------------------------------------------------


\addtolength{\abovecaptionskip}{5mm} 

\endinput
