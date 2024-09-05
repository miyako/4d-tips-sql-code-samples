//%attributes = {}
//This method has to be run on startup of the demo database
C_LONGINT:C283($i; $n)

$n:=12  //nb of strings to send to the About Component
ARRAY TEXT:C222($_xlifNames; $n)

//these xliff are mandatory
$_xlifNames{1}:="demo_name"
$_xlifNames{2}:="demo_version"
$_xlifNames{3}:="demo_author"
$_xlifNames{4}:="demo_webSite"
$_xlifNames{5}:="demo_copyright"
$_xlifNames{6}:="demo_tutorialText"
$_xlifNames{7}:="demo_legalText"
$_xlifNames{8}:="demo_aboutMenuLib"

//these xliff are optionnal
$_xlifNames{9}:="demo_licenseNeeds"
$_xlifNames{10}:="demo_licenseSite"
$_xlifNames{11}:="demo_commercialText"
$_xlifNames{12}:="demo_commercialLink"

For ($i; 1; $n)
	$Text:=Get localized string:C991($_xlifNames{$i})
	//Demo_SetVariable($_xlifNames{$i}; $Text)
End for 

$Text:=Get localized string:C991("demo_aboutMenuLib")
SET ABOUT:C316($Text; "M_About")

