<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="1.0"
    exclude-result-prefixes="tei">
    
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title>Complete Text &amp; Gallery</title>
                <link rel="stylesheet" type="text/css" href="assets/css/style.css"/>
                <link rel="stylesheet" type="text/css" href="assets/css/text_style.css"/>
            </head>
            <body class="body">
                <nav class="nav">
                    <ul>
                        <li><a href="index.html">om</a></li>
                        <li><a href="transkribering.html">transkribering</a></li>
                        <li><a href="text.html" class="active">text</a></li>
                        <li><a href="galleri.html">galleri</a></li>
                        <li><a href="bladderlage.html">blädderläge</a></li>
                    </ul>
                </nav>
                
                <div class="main-layout">
                    <aside class="left-sidebar">
                        <xsl:for-each select="//tei:pb">
                            <div class="thumb-card">
                                <a href="#page-{@n}">
                                    <!-- 1. GET FILENAME LOGIC -->
                                    <xsl:variable name="fullPath" select="@facs"/>
                                    <xsl:variable name="fileNameWithExt">
                                        <xsl:call-template name="get-filename">
                                            <xsl:with-param name="path" select="$fullPath"/>
                                        </xsl:call-template>
                                    </xsl:variable>
                                    <xsl:variable name="fileName" select="substring-before($fileNameWithExt, '.tiff')"/>
                                    
                                    <!-- 2. POINT TO ASSETS FOLDER -->
                                    <img src="assets/img/{$fileName}.jpg" alt="Page {@n}"/>
                                    <p>Page <xsl:value-of select="@n"/></p>
                                </a>
                            </div>
                        </xsl:for-each>
                    </aside>
                    
                    <main class="right-content">
                        <xsl:apply-templates select="//tei:body | //tei:front"/>
                    </main>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <!-- HELPER TEMPLATE: This extracts the file name from a path -->
    <xsl:template name="get-filename">
        <xsl:param name="path"/>
        <xsl:choose>
            <xsl:when test="contains($path, '/')">
                <xsl:call-template name="get-filename">
                    <xsl:with-param name="path" select="substring-after($path, '/')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$path"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Match Page Breaks -->
    <xsl:template match="tei:pb">
        <div id="page-{@n}" class="page-marker">FACSIMILE: PAGE <xsl:value-of select="@n"/></div>
    </xsl:template>
    
    <!-- Match Figures -->
    <xsl:template match="tei:figure">
        <div class="fig-description">
            <strong>[Image Description]:</strong> <xsl:value-of select="tei:figDesc"/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='illustration-text']">
        <div class="image-text-box">
            <strong>[Text in Image]:</strong>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='recipe']">
        <div class="recipe-box">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:p[@rend='bold uppercase']">
        <h2 class="recipe-title"><xsl:apply-templates/></h2>
    </xsl:template>
    
    <xsl:template match="tei:ab[@xml:space='preserve']">
        <pre class="ingredients"><xsl:apply-templates/></pre>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend='italic']">
        <i><xsl:apply-templates/></i>
    </xsl:template>
    
</xsl:stylesheet>