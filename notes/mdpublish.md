# mdpublish

## template html 

.. uten script-delene:

```markup
<!DOCTYPE html>
<html>

<head>
  <title>@@title</title>
  <meta charset="utf-8">
  <link rel="stylesheet" href="./styles/prism.css">
  <style>
    @@css
  </style>
</head>

<body>

  <div id="mdcontent">
    @@markdown
  </div>
  
  <!-- script section -->

</body>

</html>
```

`@@title`  blir erstattet med filnavnet til md-fil.

`@@css`  blir erstattet med innholdet i css-fil.

`@@markdown`  blir erstattet med innholdet i markdown-fil.


## Javascript

Javascript-kode som konverterer markdown til html. Dette blir gjort etter at filen 
er lastet inn i nettleseren.


```markup
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js">
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/showdown/1.3.0/showdown.min.js">
</script>
<script>
  var converter = new showdown.Converter();
  converter.setOption('simplifiedAutoLink', true);
  converter.setOption('tables', true);
  var convert = function() {
    $('#mdcontent').html(converter.makeHtml($('#mdcontent').text()));
  };
  convert();
</script>
```

Kode som kaller funksjoner som fargelegger programkode: 

```markup
<script src="./script/prism.js">
</script>
```

Kode som kaller funksjoner for matematisk notasjon:

```markup
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>
```


## CSS


```css
@import url(https://fonts.googleapis.com/css?family=Yanone+Kaffeesatz);
@import url(https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic);
@import url(https://fonts.googleapis.com/css?family=Ubuntu+Mono:400,700,400italic);
body {
  font-family: 'Droid Serif';
  margin-left: 3%;
  width: 80%;
}
h1, h2, h3 {
  font-family: 'Yanone Kaffeesatz';
  font-weight: normal;
}
pre {
  font-family: 'Ubuntu Mono';
}
.MathJax_Display {
  text-align: left !important;
  display: inline !important;
  padding-left: 1%;
}
```

## shell-script (bash)

setter parametre ...

```bash
#!/bin/sh
#
# replace placeholder in HTML file with markdown file content
#
# sverre.stikbakke@ntnu.no 18.04.2016
#

MDFILES='../notes/*.md'
TEMPLATE='notes.html'
CSS='notes.css'

PLACEHOLDERTITLE='@@title'
PLACEHOLDERCSS='@@css'
PLACEHOLDERMD='@@markdown'

HTMLOUTPUT='..'
TEMPLATES='../templates'
STYLES='../styles'
WORK='../work'

source ./processmdfiles.sh
```


...og setter inn css og markdown i html-malen:

```bash
#!/bin/sh
#
# replace placeholder in HTML file with markdown file content
#
# sverre.stikbakke@ntnu.no 18.04.2016
#

mkdir -p $WORK

for file in $MDFILES
do
  cp $file "$WORK/temp.md"
  # change '<' to '&lt;' - prism.js requirement
  sed -e 's#<#\&lt;#' -i "$WORK/temp.md"
  # change relative adress for image files
  sed -e 's#\.\./images#./images#' -i "$WORK/temp.md"

  cp "$TEMPLATES/$TEMPLATE" "$WORK/temp.html"
  # set HTML title to filename
  sed -e "s/$PLACEHOLDERTITLE/`basename $file .md`/" -i "$WORK/temp.html"
  # insert css code into html file
  sed -e "/$PLACEHOLDERCSS/{" -e "r $STYLES/$CSS" -e "d" -e "}" -i "$WORK/temp.html"
  # insert modified markdown file into html file
  sed -e "/$PLACEHOLDERMD/{" -e "r $WORK/temp.md" -e "d" -e "}" -i "$WORK/temp.html"

  echo "$HTMLOUTPUT/`basename $file .md`.html"
  mv "$WORK/temp.html" "$HTMLOUTPUT/`basename $file .md`.html"
  rm "$WORK/temp.md"
done
```