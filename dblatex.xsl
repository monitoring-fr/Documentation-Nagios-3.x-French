<?xml version='1.0' encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>

<!-- We want the TOC links in the titles, and in blue. -->
<xsl:param name="latex.hyperparam">colorlinks,linkcolor=blue,pdfstartview=FitH</xsl:param>

<!-- Show the list of examples too -->
<xsl:param name="doc.lot.show">figure,table,example</xsl:param>
<xsl:param name="doc.toc.show">1</xsl:param>
<xsl:param name="toc.section.depth">3</xsl:param>
<xsl:param name="doc.section.depth">5</xsl:param>
<xsl:param name="make.year.ranges" select="1"/>
<xsl:param name="doc.layout">coverpage toc frontmatter mainmatter index </xsl:param>
<xsl:param name="draft.mode">yes</xsl:param>
<xsl:param name="draft.watermark">0</xsl:param>
<xsl:param name="imagedata.default.scale">pagebound</xsl:param>

<xsl:param name="paper.type">A4</xsl:param>


<!-- pour forcer les variablelists sur deux lignes -->
<xsl:param name="term.breakline">1</xsl:param>

<!-- pour modifier l'apparence des tables -->
<xsl:param name="newtbl.autowitdth">1</xsl:param>
<!--
<xsl:param name="newtbl.default.colsep">0</xsl:param>
<xsl:param name="newtbl.default.rowsep">0</xsl:param>
-->
<xsl:param name="newtbl.use.hhline">1</xsl:param>

<!-- How to handle the tag linking. Avoids hyphenation in the link,
     and prevents from putting too much thing in the margin (\sloppy)
-->
<xsl:template match="book|article" mode="preamble">
  <xsl:param name="lang"/>
  <xsl:text>\def\hyperlunk#1#2{</xsl:text>
  <xsl:text>\hyperlink{#1}{\texttt{#2}}</xsl:text>
  <xsl:text>}&#10;</xsl:text>
  <xsl:text>\def\hypertag#1#2{</xsl:text>
  <xsl:text>\sloppy\hyperlink{#1}{\texttt{#2}}</xsl:text>
  <xsl:text>}&#10;</xsl:text>
  <xsl:apply-imports />
</xsl:template>

<!-- Hot links to element references -->
<xsl:template match="sgmltag">
  <xsl:variable name="class">
    <xsl:choose>
      <xsl:when test="@class">
        <xsl:value-of select="@class"/>
      </xsl:when>
      <xsl:otherwise>element</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="elem">
    <xsl:value-of select="translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                                      'abcdefghijklmnopqrstuvwxyz')"/>
  </xsl:variable>

  <xsl:variable name="elemidval">
    <xsl:value-of select="$elem"/>
    <xsl:text>.element</xsl:text>
  </xsl:variable>

  <xsl:variable name="peidval">
    <xsl:value-of select="$elem"/>
    <xsl:text>.parament</xsl:text>
  </xsl:variable>

  <xsl:variable name="elemtext">
    <xsl:call-template name="sgmltag.hyphenate">
      <xsl:with-param name="text" select="$elem"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:message><xsl:value-of select="$elemtext"/></xsl:message>

  <!-- The macro to use depends on context -->
  <xsl:variable name="hypertag">
    <xsl:choose>
    <xsl:when test="ancestor::entry">
      <xsl:value-of select="'\hyperlunk'"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="'\hypertag'"/>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$class = 'element' and count(id($elemidval)) &gt; 0">
      <xsl:variable name="targets" select="id($elemidval)"/>
      <xsl:variable name="target" select="$targets[1]"/>
      <xsl:value-of select="$hypertag"/>
      <xsl:text>{</xsl:text>
      <xsl:value-of select="$elemidval"/> 
      <xsl:text>}{</xsl:text>
      <xsl:value-of select="$elem"/>
      <xsl:text>}</xsl:text>
    </xsl:when>
    <xsl:when test="$class = 'paramentity' and count(id($peidval)) &gt; 0">
      <xsl:variable name="targets" select="id($peidval)"/>
      <xsl:variable name="target" select="$targets[1]"/>
      <xsl:value-of select="$hypertag"/>
      <xsl:text>{</xsl:text>
      <xsl:value-of select="$peidval"/> 
      <xsl:text>}{</xsl:text>
      <xsl:value-of select="concat('\%',$elem,';')"/>
      <xsl:text>}</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-imports/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
