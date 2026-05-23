<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    version="1.0">
    
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <html lang="sv">
            <head>
                <meta charset="UTF-8"/>
                <title>Bläddringsläge - Prinsessornas Kakbok</title>
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
                        <li><a href="galleri.html">Galleri</a></li>
                        <li><a href="bladderlage.html" class="active">Läsläge</a></li>
                    </ul>
                </nav>
                
                <main class="viewer-container">
                    <div class="image-area">
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
                            
                            <div class="page-content" id="page-{position()}">
                                <div class="zoom-box" onmousemove="zoomIn(event)" onmouseleave="zoomOut(event)">
                                    <img src="assets/img/{$fileName}.jpg" alt="Sida {@n}"/>
                                </div>
                                <p class="gallery-page-label"> <xsl:value-of select="@n"/></p>
                            </div>
                        </xsl:for-each>
                    </div>
                    
                    <!-- Knappar flyttade under bilden[cite: 3] -->
                    <div class="controls-container">
                        <button class="nav-button" id="prevBtn" onclick="changePage(-1)">&lt;</button>
                        <span id="pageIndicator">Sida 1 av <xsl:value-of select="count(//tei:pb)"/></span>
                        <button class="nav-button" id="nextBtn" onclick="changePage(1)">&gt;</button>
                    </div>
                </main>
                
                <footer>
                    <strong>Prinsessornas Kakbok</strong><br/>
                    Utgiven av: Husmodern
                </footer>
                
                <script>
                    let current = 1;
                    const total = <xsl:value-of select="count(//tei:pb)"/>;
                    
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
                    
                    function updateView(idx) {
                    document.querySelectorAll('.page-content').forEach(p => p.style.display = 'none');
                    document.getElementById('page-' + idx).style.display = 'block';
                    document.getElementById('pageIndicator').innerText = "Sida " + idx + " av " + total;
                    document.getElementById('prevBtn').disabled = (idx === 1);
                    document.getElementById('nextBtn').disabled = (idx === total);
                    }
                    
                    function changePage(step) {
                    current += step;
                    updateView(current);
                    }
                    
                    updateView(1);
                </script>
            </body>
        </html>
    </xsl:template>
    
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
