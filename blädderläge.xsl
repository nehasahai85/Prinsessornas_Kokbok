<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="1.0"
    exclude-result-prefixes="tei">
    
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <html lang="sv">
            <head>
                <meta charset="UTF-8"/>
                <title>Blädderläge | Prinsessornas Kakbok</title>
                <link rel="stylesheet" type="text/css" href="assets/css/style.css"/>
                <style>
                    body { margin: 0; font-family: "Times New Roman", serif; background-color: #f6f1e7; }
                    
                    .nav ul { list-style: none; 
                    display: flex; 
                    justify-content: center; 
                    gap: 20px; 
                    padding: 20px; 
                    margin: 0; 
                    background-color: #d4af37; 
                    }
                    
                    .nav a.active { text-decoration: underline; 
                    } 
                    
                    .content { text-align: center; 
                    padding: 20px; 
                    }
                    
                    .carousel-container { width: 100%; 
                    overflow: hidden; 
                    position: relative; 
                    margin: auto; 
                    }
                    
                    .carousel-slides { display: 
                    flex; transition: 
                    transform 0.5s ease-in-out; 
                    }
                    
                    .carousel-slide { min-width: 100%; 
                    display: flex; 
                    justify-content: center; 
                    align-items: center; 
                    }
                    
                    .carousel-slide img { width: 80%; 
                    max-height: 90vh; object-fit: contain; 
                    border: 2px solid #d4af37; 
                    background-color: white; 
                    }
                    
                    .carousel-buttons { text-align: center; 
                    margin-top: 15px; 
                    }
                    
                    .carousel-buttons button { padding: 10px 20px; 
                    font-size: 2rem; 
                    cursor: pointer; 
                    margin: 0 10px; 
                    }
                    
                    
                </style>
            </head>
            <body class="body">
                <nav class="nav">
                    <ul>
                        <li><a href="index.html">Om</a></li>
                        <li><a href="transkribering.html">Transkribering</a></li>
                        <li><a href="text.html">Text</a></li>
                        <li><a href="galleri.html">Galleri</a></li>
                        <li><a href="bladderlage.html" class="active">Blädderläge</a></li>
                    </ul>
                </nav>
                
                <div class="content">
                    <h1 style="text-align:center;">Blädderläge</h1>
                    <p style="text-align:center;">Bläddra mellan sidorna i Prinsessornas Kakbok.
                    </p>
                    
                <div class="carousel-slides" id="carouselSlides">    
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
                                <xsl:otherwise><xsl:value-of select="$fileNameWithExt"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
             
                        <!-- SINGLE SLIDE --> 
                                    
                        <div class="carousel-slide"> 
                             <img src="assets/img/{$fileName}.jpg" 
                                  alt="Sida {@n} ur Prinsessornas Kakbok" 
                                  title="Prinsessornas Kokbok sida {@n}"/> 
                                        
                              <p class="blädderläge-page-label"> 
                                  Sida <xsl:value-of select="@n"/> 
                                        
                             </p>
                        </div>
                            
                    </xsl:for-each>
                                
                   </div>
                    
                </div>
                
                <script>
                    let currentSlide = 0; 
                    function showSlide(index) {
                    const slides = document.getElementById("carouselSlides"); 
                    const totalSlides = document.querySelectorAll(".carousel-slide").length; 
                    if(index &lt; 0) { 
                    currentSlide = totalSlides - 1; 
                    }
                    
                    else if(index &gt;= totalSlides) { 
                    currentSlide = 0; 
                    } 
                    else {currentSlide = index; 
                    }
                    
                    slides.style.transform = "translateX(-" + (currentSlide * 100) + "%)"; 
                    }
                    
                    function nextSlide() { 
                    showSlide(currentSlide + 1); 
                    } 
                    
                    function prevSlide() { 
                    showSlide(currentSlide - 1); 
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