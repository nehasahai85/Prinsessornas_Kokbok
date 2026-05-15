<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    version="2.0">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <!-- 1. ROOT TEMPLATE -->
    <xsl:template match="/">
        <html lang="sv">
            <head>
                <meta charset="UTF-8"/>
                <title>Transkribering - Prinsessornas Kakbok</title>
                <link rel="stylesheet" type="text/css" href="assets/css/style.css"/>
            </head>
            <body class="body">
                <nav class="nav">
                    <ul>
                        <li><a href="index.html">Hem</a></li>
                        <li><a href="transkribering.html" class="active">Transkribering</a></li>
                        <li><a href="text.html">Text</a></li>
                        <li><a href="galleri.html">Galleri</a></li>
                        <li><a href="bladderlage.html">LÄS-LÄGE</a></li>
                    </ul>
                </nav>
                
                <div class="content">
                    <h1>Transkribering av Recept</h1>
                </div>
                
                <!-- Side-by-side Page Loop -->
                <xsl:for-each select="//tei:pb">
                    <!-- Define the current page number for logic checks -->
                    <xsl:variable name="pageNum" select="@n"/>
                    
                    <div class="page-wrapper">
                        <!-- LEFT SIDE: Image -->
                        <div class="image-side">
                            <xsl:variable name="fileName" select="substring-before(tokenize(@facs, '/')[last()], '.')" />
                            <img src="assets/img/{$fileName}.jpg" alt="{@n}"/>
                        </div>
                        
                        <!-- RIGHT SIDE: Text Content -->
                        <div class="text-side">
                           <!-- Standard processing for all other pages -->
                           <xsl:apply-templates select="following-sibling::*[generate-id(preceding-sibling::tei:pb[1]) = generate-id(current())]"/>
                        </div>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
    
    <!-- 2. CONSOLIDATED RENDERING ENGINE -->
    <!-- This handles most paragraphs and divs by turning @rend into a class -->
    <xsl:template match="tei:p[@rend] | tei:div[@rend]" priority="1">
        <div class="{@rend}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- 3. SPECIFIC OVERRIDES (High Priority) -->
    
    <!-- Recipe Titles -->
    <xsl:template match="tei:p[@rend = 'bold uppercase']" priority="2">
        <span class="recipe-title-uppercase"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:p[@rend = 'bold']" priority="2">
        <span class="recipe-title"><xsl:apply-templates/></span>
    </xsl:template>
    
    <!-- Ingredients -->
    <xsl:template match="tei:ab[@xml:space = 'preserve']" priority="2">
        <pre class="ingredients"><xsl:apply-templates/></pre>
    </xsl:template>
    
    <!-- Figures & Icons -->
    <xsl:template match="tei:figure[@rend = 'crown-icon']" priority="2">
        <span class="crown-icon"></span>
    </xsl:template>
    <xsl:template match="tei:figDesc" priority="3"/>
    <xsl:template match="tei:figure[@rend='main-cover-art']" priority="3"/>
    <xsl:template match="tei:p[@rend='back-italic-intro']" priority="3">
        <div class="back-italic-intro">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:p[@rend='cover-title-top']" priority="3">
        <div class="cover-title-top">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:p[@rend='cover-title-bottom']" priority="3">
        <div class="cover-title-bottom">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <!-- 4. GENERAL ELEMENTS -->
    <xsl:template match="tei:p" priority="0">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    

    
    <xsl:template match="tei:hr">
        <hr class="{@rend}"/>
    </xsl:template>
    
</xsl:stylesheet>