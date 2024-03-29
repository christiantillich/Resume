% This class was taken from https://www.latextemplates.com/template/twenty-seconds-resumecv and
% heavily modified to serve as a Rmarkdown/LateX template circa 8/20/2018. 

\ProvidesClass{twentysecondcv}[2017/01/08 CV class]
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}

%----------------------------------------------------------------------------------------
%	 REQUIRED PACKAGES
%----------------------------------------------------------------------------------------

\RequirePackage[sfdefault]{ClearSans}
\RequirePackage[T1]{fontenc}
\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{ragged2e}
\RequirePackage{etoolbox}
\RequirePackage{ifmtarg}
\RequirePackage{ifthen}
\RequirePackage{pgffor}
\RequirePackage{marvosym}
\RequirePackage{parskip}
\RequirePackage{geometry}
\RequirePackage{hyperref}
\RequirePackage{fontawesome}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage[tiny]{titlesec}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax



%----------------------------------------------------------------------------------------
%	 COLOURS
%----------------------------------------------------------------------------------------

\definecolor{white}{RGB}{255,255,255}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{sidecolor}{HTML}{e3f2fc}
\definecolor{mainblue}{HTML}{0E5484}
\definecolor{maingray}{HTML}{B9B9B9}
\definecolor{lightblue}{HTML}{e3f2fc}

%----------------------------------------------------------------------------------------
%	 MISC CONFIGURATIONS
%----------------------------------------------------------------------------------------

\renewcommand{\bfseries}{\color{gray}} % Make \textbf produce coloured text instead

\pagestyle{empty} % Disable headers and footers

\setlength{\parindent}{0pt} % Disable paragraph indentation

\newcommand{\geometryprop}[1]{\csname Gm@#1\endcsname} %Gets an arbitrary geometry property

%----------------------------------------------------------------------------------------
%	 SIDEBAR DEFINITIONS
%----------------------------------------------------------------------------------------



\newdimen\lmargin \setlength{\lmargin}{0.9\dimexpr\geometryprop{lmargin}} %Reads in total sidebar length from .Rmd
\newdimen\tmargin \setlength{\tmargin}{\dimexpr \geometryprop{tmargin}} %Reads in top margin from .Rmd
\setlength{\TPHorizModule}{\lmargin} % Left margin
\setlength{\TPVertModule}{\tmargin} % Top margin
%\oddsidemargin = 0.5cm

\newlength\imagewidth
\newlength\imagescale
\pgfmathsetlength{\imagewidth}{0.70\lmargin}
\pgfmathsetlength{\imagescale}{\imagewidth/600}

\newlength{\TotalSectionLength} % Define a new length to hold the remaining line width after the section title is printed
\newlength{\SectionTitleLength} % Define a new length to hold the width of the section title
\newcommand{\profilesection}[1]{%
	\setlength\TotalSectionLength{\linewidth}% Set the total line width
	\settowidth{\SectionTitleLength}{\huge #1 }% Calculate the width of the section title
	\addtolength\TotalSectionLength{-\SectionTitleLength}% Subtract the section title width from the total width
	\addtolength\TotalSectionLength{-2.22221pt}% Modifier to remove overfull box warning
	\vspace{8pt}% Whitespace before the section title
	{\color{mainblue} \huge #1 \vspace{0.3ex} {\color{maingray}\hrule height 0.1ex}}% Print the title and auto-width rule
}

%\vspace{0.3ex}
%	{\color{maingray}\hrule height 0.3ex}

\newdimen\test \setlength{\test}{\dimexpr \geometryprop{lmargin}} %Define the left margin length so we can make everything relative to it
\newdimen\other \setlength{\other}{0.10\test}

% Define custom commands for CV info
\newcommand{\cvdate}[1]{\renewcommand{\cvdate}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvsite}[1]{\renewcommand{\cvsite}{#1}}
%%\newcommand{\aboutme}[1]{\renewcommand{\aboutme}{#1}}
\newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}

% Command for printing the contact information icons
\newcommand*\icon[1]{\tikz[baseline=(char.base)]{\node[shape=circle,draw,inner sep=1pt, fill=mainblue,mainblue,text=white] (char) {#1};}}

% Command for printing skill progress bars
\newcommand\skillwidth{0.85\lmargin}
\newcommand\skillheight{0.2}
\newcommand\statistics[1]{ 
	\renewcommand{\statistics}{
		\begin{tikzpicture}
			\foreach [count=\i] \x/\y in {#1}{
				\draw[fill=maingray,maingray] (0,\i) rectangle (\skillwidth,\i+\skillheight);
				\draw[fill=white,mainblue](0,\i) rectangle (\y*\skillwidth/6,\i+\skillheight);
				\node [above right] at (0,\i+\skillheight) {\small\textsf{\x}};
			}
		\end{tikzpicture}
	}
}
\newcommand\programming[1]{ 
	\renewcommand{\programming}{
		\begin{tikzpicture}
			\foreach [count=\i] \x/\y in {#1}{
				\draw[fill=maingray,maingray] (0,\i) rectangle (\skillwidth,\i+\skillheight);
				\draw[fill=white,mainblue](0,\i) rectangle (\y*\skillwidth/6,\i+\skillheight);
				\node [above right] at (0,\i+\skillheight) {\small\textsf{\x}};
			}
		\end{tikzpicture}
	}
}


% Command for printing skills text
\newcommand\skillstext[1]{ 
	\renewcommand{\skillstext}{
		\begin{flushleft}
			\foreach [count=\i] \x/\y in {#1}{ 
				\x$ \star $\y
			}
		\end{flushleft}
	}
}

%----------------------------------------------------------------------------------------
%	 SIDEBAR LAYOUT
%----------------------------------------------------------------------------------------

\newcommand{\makeprofile}{

	\begin{tikzpicture}[remember picture,overlay]
   		\node [
			rectangle, 
			fill=sidecolor, 
			anchor=north east, 
			minimum width=\lmargin + 0.5cm, 
			minimum height=\paperheight
		] (box) at (-0.10\lmargin,0.5cm + \tmargin){};
	\end{tikzpicture}

	%------------------------------------------------

	\begin{textblock}{0.85}(0.05, 0.1)
			
		%-------PICTURE
		\vskip \tmargin
		\ifthenelse{\equal{\profilepic}{}}{}{
			\begin{center}
				\begin{tikzpicture}
					\clip (\imagewidth/2, -\imagewidth/2) circle (\imagewidth/2);
					\node[anchor=north west, inner sep=0pt, outer sep=0pt] at (0,0) {
						\includegraphics[width=\imagewidth]{\profilepic}
					};
				\end{tikzpicture}
			\end{center}
		}

		%-------NAME AND TITLE
		\centering
		{\Large\color{mainblue}\cvname}
		\vskip 0.05cm
		{\normalsize\color{black!80}\cvjobtitle}

		%------------------------------------------------
		\renewcommand{\arraystretch}{1.6}
		\begin{tabular}{c c c} %p{0.5cm} @{\hskip 0.1cm}p{0.7\lmargin}}
			\ifthenelse{\equal{\cvmail}{}}{}{ \href{mailto:\cvmail }{\Email}}
			\ifthenelse{\equal{\cvnumberphone}{}}{}{ \href{tel:\cvnumberphone }{\Telefon}}
			\ifthenelse{\equal{\cvsite}{}}{}{ \href{\cvsite}{\faGithub}}
			\ifthenelse{\equal{\cvaddress}{}}{}{ \href{\cvaddress }{\Mundus}}


			%\ifthenelse{\equal{\cvdate}{}}{}{\textsc{\large \Info} & \cvdate\\}
			%\ifthenelse{\equal{\cvaddress}{}}{}{\textsc{\large \Letter} & \cvaddress\\}
			%\ifthenelse{\equal{\cvnumberphone}{}}{}{\textsc{\large \Telefon} & \cvnumberphone\\}
			%\ifthenelse{\equal{\cvsite}{}}{}{\textsc{\large \Mundus} & \cvsite\\}
			%\ifthenelse{\equal{\cvmail}{}}{}{\textsc{\large \Email} & \cvmail\\}
		\end{tabular}


		%------------------------------------------------

		\profilesection{\centering Stats}
		\statistics

		\profilesection{\centering Code}
      	\programming

		\footnotesize The skill scale is from 0 (Used Once in College) to 6 (Expert). 3 implies ability to plan and complete average tasks within accurate and reasonable timelines.
		
			
		%------------------------------------------------
			
	\end{textblock}
}






%----------------------------------------------------------------------------------------
%	 SECTION TITLE
%----------------------------------------------------------------------------------------


\newcounter{sectionCounter}
\renewcommand{\section}[1]{
	\ifcase\value{sectionCounter} 
	\else
		\par\vspace{5\parskip}
	\fi
	{%
		\huge\color{mainblue} #1%
	}
   	\vspace{0.3ex}
	{\color{maingray}\hrule height 0.3ex}
    \stepcounter{sectionCounter}
}

\renewcommand{\subsection}[1]{
	\par\vspace{3\parskip}{%
		\large\color{mainblue} #1%
	}
	\par\vspace{0.5\parskip}%
}