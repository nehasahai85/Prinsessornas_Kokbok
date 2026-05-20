<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="1.0"
    exclude-result-prefixes="tei">
    
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <html lang="sv">
            <head>
                <meta charset="UTF-8"/>
                <title>Galleri | Prinsessornas Kakbok</title>
                <!-- first: the main site style (menu, background, etc) -->
                <link rel="stylesheet" type="text/css" href="assets/css/style.css"/>
                <!-- second: the specific viewer style -->
                <link rel="stylesheet" type="text/css" href="assets/css/gallery_shared.css"/>
            </head>
            <body class="body">
                <nav class="nav">
                    <ul>
                        <li><a href="index.html">Hem</a></li>
                        <li><a href="transkribering.html">Transkribering</a></li>
                        <li><a href="text.html">Text</a></li>
                        <li><a href="galleri.html" class="active">Galleri</a></li>
                        <li><a href="bladderlage.html">Läsläge</a></li>
                    </ul>
                </nav>
                
                <div class="content">
                    <h1 style="text-align:center;">Interaktivt Galleri</h1>
                    <p style="text-align:center;">Håll musen över bilden för att zooma in och panorera.</p>
                    
                    <xsl:for-each select="//tei:pb">
                        <xsl:variable name="fullPath" select="@facs"/>
                        <xsl:variable name="fileNameWithExt">
                            <xsl:call-template name="get-filename">
                                <xsl:with-param name="path" select="$fullPath"/>
                            </xsl:call-template>
                        </xsl:variable>
                        
                        <xsl:variable name="fileName">
                            <xsl:choose>
                                <xsl:when test="contains($fileNameWithExt, '.tiff')">
                                    <xsl:value-of select="substring-before($fileNameWithExt, '.tiff')"/>
                                </xsl:when>
                                <xsl:otherwise><xsl:value-of select="$fileNameWithExt"/></xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        
                        <div class="gallery-item">
                            <div class="zoom-box" onmousemove="zoomIn(event)" onmouseleave="zoomOut(event)">
                                <img src="assets/img/{$fileName}.jpg" alt="Sida {@n}"/>
                            </div>
                            <p class="gallery-page-label">Sida <xsl:value-of select="@n"/></p>
                        </div>
                    </xsl:for-each>
                </div>
                
                <script>
                    function zoomIn(e) {
                    const box = e.currentTarget;
                    const img = box.querySelector('img');
                    const rect = box.getBoundingClientRect();
                    const x = e.clientX - rect.left;
                    const y = e.clientY - rect.top;
                    const xPercent = (x / rect.width) * 100;
                    const yPercent = (y / rect.height) * 100;
                    img.style.transformOrigin = xPercent + "% " + yPercent + "%";
                    img.style.transform = "scale(2.5)";
                    }
                    function zoomOut(e) {
                    const img = e.currentTarget.querySelector('img');
                    img.style.transform = "scale(1)";
                    img.style.transformOrigin = "center center";
                    }
                </script>
            </body>
        </html>
    </xsl:template>
    
    <!-- Priority fixes for common paragraph/rendition types -->
    <xsl:template match="tei:p[@rend='bold uppercase']" priority="2">
        <h2 class="recipe-title-uppercase"><xsl:apply-templates/></h2>
    </xsl:template>
    
    <xsl:template match="tei:p[@rend='procedure']" priority="2">
        <div class="procedure"><xsl:apply-templates/></div>
    </xsl:template>
    
    <xsl:template match="tei:p" priority="1">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <!-- Filename helper -->
    <xsl:template name="get-filename">
        <xsl:param name="path"/>
        <xsl:choose>
            <xsl:when test="contains($path, '/')">
                <xsl:call-template name="get-filename">
                    <xsl:with-param name="path" select="substring-after($path, '/')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="$path"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>