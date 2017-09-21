<?xml version='1.0' encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:date="http://exslt.org/dates-and-times" exclude-result-prefixes="date" version='1.0'>

<!-- Path of docbook chunk stylesheets -->
<xsl:import href="../utils/docbook-xsl-1.76.1/xhtml-1_1/chunk.xsl"/>

<!-- TOC generation (to be polished) -->
<xsl:param name="doc.lot.show">figure,table,example</xsl:param>
<xsl:param name="doc.toc.show">1</xsl:param>
<xsl:param name="toc.section.depth">2</xsl:param>
<xsl:param name="doc.section.depth">3</xsl:param>
<xsl:param name="generate.section.toc.level" select="3"></xsl:param>
<xsl:param name="toc.max.depth">2</xsl:param>
<!-- html elements for toc -->
<xsl:param name="toc.list.type">ul</xsl:param>
<!-- Index settings (not working at that time) -->
<xsl:param name="generate.index" select="1"></xsl:param>
<xsl:param name="index.method">basic</xsl:param>
<xsl:param name="make.year.ranges" select="1"/>
<xsl:param name="doc.layout">coverpage toc frontmatter mainmatter index </xsl:param>
<!-- Settings for draft mode -->
<xsl:param name="draft.mode">no</xsl:param>
<xsl:param name="draft.watermark">0</xsl:param>
<!-- To be seen later -->
<xsl:param name="imagedata.default.scale">pagebound</xsl:param>
<xsl:param name="chunker.output.indent">yes</xsl:param>
<!-- Output the chapter id as filename.html -->
<xsl:param name="use.id.as.filename">1</xsl:param>
<!-- Use external CSS Stylesheet -->
<xsl:param name="html.stylesheet">style.css</xsl:param>
<!-- Chunks at the chapter level, not section by default -->
<xsl:param name="chunk.section.depth" select="0"></xsl:param>
<!-- All XHTM styling is done via external by CSS -->
<xsl:param name="css.decoration" select="0"></xsl:param>
<xsl:param name="html.extra.head.links" select="0"></xsl:param>
<!-- Tables elements controlled by CSS -->
<xsl:param name="table.borders.with.css" select="1"></xsl:param>
<!-- No external frame like _blank or _top for links -->
<xsl:param name="ulink.target">0</xsl:param>
<!-- XML ouput encoding -->
<xsl:param name="chunker.output.encoding">UTF-8</xsl:param>
<!-- Inherit keywords from ancestor elements -->
<xsl:param name="inherit.keywords" select="1"></xsl:param>
<!-- <hr> tag under header template -->
<xsl:param name="header.rule" select="0"></xsl:param>
<!-- <hr> tag under footer template -->
<xsl:param name="footer.rule" select="0"></xsl:param>
<!-- Try to assure we have valid XHTML -->
<xsl:param name="make.valid.html" select="1"></xsl:param>
<!-- Try to cleanup XHTML output -->
<xsl:param name="html.cleanup" select="1"></xsl:param>
<!-- Try to cleanup XHTML output -->
<xsl:param name="generate.id.attributes" select="1"></xsl:param>
<!-- text and graphics in admonitions (note, warning…) -->
<xsl:param name="admon.textlabel" select="0"></xsl:param>
<xsl:param name="admon.graphics" select="0"/>
<!-- highlights source code -->
<xsl:param name="highlight.source" select="1"></xsl:param>

<!-- ============================== user.preroot ================================== -->
<xsl:template name="chunk-element-content">
  <xsl:param name="prev"/>
  <xsl:param name="next"/>
  <xsl:param name="nav.context"/>
  <xsl:param name="content">
    <xsl:apply-imports/>
  </xsl:param>

<xsl:call-template name="user.preroot"/>

  <html>
    <xsl:call-template name="html.head">
      <xsl:with-param name="prev" select="$prev"/>
      <xsl:with-param name="next" select="$next"/>
    </xsl:call-template>

    <body>
    <div class="container">
      <xsl:call-template name="body.attributes"/>
      <xsl:call-template name="user.header.navigation"/>

      <xsl:call-template name="header.navigation">
        <xsl:with-param name="prev" select="$prev"/>
        <xsl:with-param name="next" select="$next"/>
        <xsl:with-param name="nav.context" select="$nav.context"/>
      </xsl:call-template>

      <xsl:call-template name="user.header.content"/>

      <xsl:copy-of select="$content"/>

      <xsl:call-template name="user.footer.content"/>

      <xsl:call-template name="footer.navigation">
        <xsl:with-param name="prev" select="$prev"/>
        <xsl:with-param name="next" select="$next"/>
        <xsl:with-param name="nav.context" select="$nav.context"/>
      </xsl:call-template>

      <xsl:call-template name="user.footer.navigation"/>
    </div>
    <!-- Piwik -->
<script type="text/javascript">
  var _paq = _paq || [];
  /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
  _paq.push(['trackPageView']);
  _paq.push(['enableLinkTracking']);
  (function() {
    var u="//analytics.monitoring-fr.org/";
    _paq.push(['setTrackerUrl', u+'piwik.php']);
    _paq.push(['setSiteId', '4']);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
  })();
</script>
<noscript><p><img src="//analytics.monitoring-fr.org/piwik.php?idsite=4&rec=1" style="border:0;" alt="" /></p></noscript>
<!-- End Piwik Code -->
    </body>
  </html>
  <xsl:value-of select="$chunk.append"/>
</xsl:template>

<!-- ==================================================================== -->

<!-- Start Breadcrumb generation -->
<xsl:template name="breadcrumbs">
  <xsl:param name="this.node" select="."/>
  <div class="breadcrumbs">
	 <ul class="breadcrumbs">
    <xsl:for-each select="$this.node/ancestor::*">
      <li class="breadcrumb-link">
        <a>
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="object" select="."/>
              <xsl:with-param name="context" select="$this.node"/>
            </xsl:call-template>
          </xsl:attribute>
          <xsl:apply-templates select="." mode="title.markup"/>
        </a>
      <xsl:text> &gt; </xsl:text>
	   </li>
    </xsl:for-each>
    <!-- And display the current node, but not as a link -->
    <li class="breadcrumb-node">
      <xsl:apply-templates select="$this.node" mode="title.markup"/>
    </li>
	 </ul>
  </div>
</xsl:template>

<xsl:template name="user.header.content">
  <xsl:call-template name="breadcrumbs"/>
</xsl:template>
<!-- End Breadcrumb generation -->

<!-- Start date in XHTML header meta -->
<xsl:template name="user.head.content">
  <meta name="date">
    <xsl:attribute name="content">
      <xsl:call-template name="datetime.format">
        <xsl:with-param name="date" select="date:date-time()"/>
        <xsl:with-param name="format" select="'d/m/Y'"/>
      </xsl:call-template>
    </xsl:attribute>
  </meta>
</xsl:template>
<!-- End date in XHTML header meta -->

<!-- ==================================================================== -->

<xsl:template name="header.navigation">
  <xsl:param name="prev" select="/foo"/>
  <xsl:param name="next" select="/foo"/>
  <xsl:param name="nav.context"/>

  <xsl:variable name="home" select="/*[1]"/>
  <xsl:variable name="up" select="parent::*"/>

  <xsl:variable name="row1" select="$navig.showtitles != 0"/>
  <xsl:variable name="row2" select="count($prev) &gt; 0                                     or (count($up) &gt; 0                                          and generate-id($up) != generate-id($home)                                         and $navig.showtitles != 0)                                     or count($next) &gt; 0"/>

  <xsl:if test="$suppress.navigation = '0' and $suppress.header.navigation = '0'">
    <div class="navheader">
      <xsl:if test="$row1 or $row2">
        <ul class="docnav">
          <xsl:if test="$row1">
              <li class="up">
                <xsl:choose>
                  <xsl:when test="count($up) &gt; 0                                   and generate-id($up) != generate-id($home)                                   and $navig.showtitles != 0">
                    <xsl:apply-templates select="$up" mode="object.title.markup"/>
                  </xsl:when>
                  <xsl:otherwise>&#160;</xsl:otherwise>
                </xsl:choose>
              </li>
          </xsl:if>

          <xsl:if test="$row2">
					<li class="up">
                <xsl:apply-templates select="." mode="object.title.markup"/>
					</li>
					<li class="previous">
                <xsl:if test="count($prev)&gt;0">
                  <a accesskey="p">
                    <xsl:attribute name="href">
                      <xsl:call-template name="href.target">
                        <xsl:with-param name="object" select="$prev"/>
                      </xsl:call-template>
                    </xsl:attribute>
                    <xsl:call-template name="navig.content">
                      <xsl:with-param name="direction" select="'prev'"/>
                    </xsl:call-template>
                  </a>
                </xsl:if>
                <xsl:text>&#160;</xsl:text>
              </li>
               <li class="next">
                <xsl:text>&#160;</xsl:text>
                <xsl:if test="count($next)&gt;0">
                  <a accesskey="n">
                    <xsl:attribute name="href">
                      <xsl:call-template name="href.target">
                        <xsl:with-param name="object" select="$next"/>
                      </xsl:call-template>
                    </xsl:attribute>
                    <xsl:call-template name="navig.content">
                      <xsl:with-param name="direction" select="'next'"/>
                    </xsl:call-template>
                  </a>
                </xsl:if>
               </li>
          </xsl:if>
        </ul>
      </xsl:if>
      <xsl:if test="$header.rule != 0">
        <hr/>
      </xsl:if>
    </div>
  </xsl:if>
</xsl:template>

<!-- ==================================================================== -->

<!-- ============================== footer.navigation ====================== -->

<xsl:template name="footer.navigation">
  <xsl:param name="prev" select="/foo"/>
  <xsl:param name="next" select="/foo"/>
  <xsl:param name="nav.context"/>

  <xsl:variable name="home" select="/*[1]"/>
  <xsl:variable name="up" select="parent::*"/>

  <xsl:variable name="row1" select="count($prev) &gt; 0                                     or count($up) &gt; 0                                     or count($next) &gt; 0"/>

  <xsl:variable name="row2" select="($prev and $navig.showtitles != 0)                                     or (generate-id($home) != generate-id(.)                                         or $nav.context = 'toc')                                     or ($chunk.tocs.and.lots != 0                                         and $nav.context != 'toc')                                     or ($next and $navig.showtitles != 0)"/>

  <xsl:if test="$suppress.navigation = '0' and $suppress.footer.navigation = '0'">
    <div class="navfooter">
      <xsl:if test="$footer.rule != 0">
        <hr/>
      </xsl:if>

      <xsl:if test="$row1 or $row2">
        <ul class="docnav">
          <xsl:if test="$row1">
            <li class="previous">
                <xsl:if test="count($prev)&gt;0">
                  <a accesskey="p">
                    <xsl:attribute name="href">
                      <xsl:call-template name="href.target">
                        <xsl:with-param name="object" select="$prev"/>
                      </xsl:call-template>
                    </xsl:attribute>
                    <xsl:call-template name="navig.content">
                      <xsl:with-param name="direction" select="'prev'"/>
                    </xsl:call-template>
                  </a>
                </xsl:if>
                <xsl:text>&#160;</xsl:text>
              </li>
              <li class="up">
                <xsl:choose>
                  <xsl:when test="count($up)&gt;0                                   and generate-id($up) != generate-id($home)">
                    <a accesskey="u">
                      <xsl:attribute name="href">
                        <xsl:call-template name="href.target">
                          <xsl:with-param name="object" select="$up"/>
                        </xsl:call-template>
                      </xsl:attribute>
                      <xsl:call-template name="navig.content">
                        <xsl:with-param name="direction" select="'up'"/>
                      </xsl:call-template>
                    </a>
                  </xsl:when>
                  <xsl:otherwise>&#160;</xsl:otherwise>
                </xsl:choose>
              </li>
              <li class="next">
                <xsl:text>&#160;</xsl:text>
                <xsl:if test="count($next)&gt;0">
                  <a accesskey="n">
                    <xsl:attribute name="href">
                      <xsl:call-template name="href.target">
                        <xsl:with-param name="object" select="$next"/>
                      </xsl:call-template>
                    </xsl:attribute>
                    <xsl:call-template name="navig.content">
                      <xsl:with-param name="direction" select="'next'"/>
                    </xsl:call-template>
                  </a>
                </xsl:if>
              </li>
          </xsl:if>

          <xsl:if test="$row2">
            <li class="previous">
                <xsl:if test="$navig.showtitles != 0">
                  <xsl:apply-templates select="$prev" mode="object.title.markup"/>
                </xsl:if>
                <xsl:text>&#160;</xsl:text>
              </li>
              <li class="home">
                <xsl:choose>
                  <xsl:when test="$home != . or $nav.context = 'toc'">
                    <a accesskey="h">
                      <xsl:attribute name="href">
                        <xsl:call-template name="href.target">
                          <xsl:with-param name="object" select="$home"/>
                        </xsl:call-template>
                      </xsl:attribute>
                      <xsl:call-template name="navig.content">
                        <xsl:with-param name="direction" select="'home'"/>
                      </xsl:call-template>
                    </a>
                    <xsl:if test="$chunk.tocs.and.lots != 0 and $nav.context != 'toc'">
                      <xsl:text>&#160;|&#160;</xsl:text>
                    </xsl:if>
                  </xsl:when>
                  <xsl:otherwise>&#160;</xsl:otherwise>
                </xsl:choose>

                <xsl:if test="$chunk.tocs.and.lots != 0 and $nav.context != 'toc'">
                  <a accesskey="t">
                    <xsl:attribute name="href">
                      <xsl:apply-templates select="/*[1]" mode="recursive-chunk-filename">
                        <xsl:with-param name="recursive" select="true()"/>
                      </xsl:apply-templates>
                      <xsl:text>-toc</xsl:text>
                      <xsl:value-of select="$html.ext"/>
                    </xsl:attribute>
                    <xsl:call-template name="gentext">
                      <xsl:with-param name="key" select="'nav-toc'"/>
                    </xsl:call-template>
                  </a>
                </xsl:if>
              </li>
              <li class="next">
                <xsl:text>&#160;</xsl:text>
                <xsl:if test="$navig.showtitles != 0">
                  <xsl:apply-templates select="$next" mode="object.title.markup"/>
                </xsl:if>
              </li>
          </xsl:if>
        </ul>
      </xsl:if>
    </div>
  </xsl:if>
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>
