<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="2.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title>Transkribering - Prinsessornas Kakbok</title>
                <link rel="stylesheet" type="text/css" href="assets/css/style.css"/>
               
            </head>
            <body>
                <nav class="nav">
                    <ul>
                        <li><a href="index.html">Om</a></li>
                        <li><a href="transkribering.html" class="active">Transkribering</a></li>
                        <li><a href="text.html">Text</a></li>
                        <li><a href="galleri.html">Galleri</a></li>
                        <li><a href="bladderlage.html">Blädderläge</a></li>
                    </ul>
                </nav>
                <div class="content">
                    <h1>Transkribering av Recept</h1>
                    <xsl:apply-templates select="//recipe"/> 
                </div>
            
                <xsl:for-each select="//tei:pb">
                    <div class="page-wrapper">
                        <div class="image-side">
                            <!-- LOGIC: Extract filename from TIFF path and point to JPG assets -->
                            <xsl:variable name="fileName" select="substring-before(tokenize(@facs, '/')[last()], '.')" />
                            
                            <img src="assets/img/{$fileName}.jpg" alt="Original Page {@n}"/>
                        </div>
                        <div class="text-side">
                            <xsl:apply-templates
                                select="following-sibling::*[generate-id(preceding-sibling::tei:pb[1]) = generate-id(current())]"/>
                        </div>
                    </div>
                </xsl:for-each>
            
            
            
            <!-- <xsl:for-each select="//tei:pb">
                    <div class="page-wrapper">
                        <div class="image-side">
                            <img src="{@facs}" alt="Original Page {@n}"/>
                        </div>
                        <div class="text-side">
                            <xsl:apply-templates
                                select="following-sibling::*[generate-id(preceding-sibling::tei:pb[1]) = generate-id(current())]"/>
                        </div>
                    </div>
                </xsl:for-each>  -->    
                
            </body>
        </html>
    </xsl:template>
    

    <xsl:template match="tei:figure[@rend = 'crown-icon']">
        <div class="{@rend}">
        </div>
    </xsl:template>
    <xsl:template match="tei:figure[@rend = 'main-illustration']">
        <div class="{@rend}">
        </div>
    </xsl:template>
    
    <xsl:template match="tei:p[@rend] | tei:div[@rend]">
        <xsl:element name="{local-name()}">
            <xsl:attribute name="class">
                <xsl:value-of select="@rend"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    
    
    <xsl:template match="tei:p[@rend = 'cover-title-top' or @rend = 'cover-title-bottom']">
        <div class="{@rend}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:figure[@rend = 'crown-icon']">
        <span class="crown-icon"></span>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='front-cover']">
        <div class="front-cover-container">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:p[@rend='cover-title-top']">
        <p class="cover-title-top">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="tei:p[@rend='cover-title-bottom']">
        <p class="cover-title-bottom">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:p[@rend = 'bold uppercase']">
        <span class="recipe-title">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
      
    <xsl:template match="tei:figure[@rend='main-cover-art']">
        <div class="cover-image-placeholder">
            <img src="path/to/princesses-cake-illustration.jpg" alt="Princesses and Cake Illustration" />
        </div>
    </xsl:template>
    <xsl:template match="tei:hr">
        <hr class="{@rend}"/>
    </xsl:template>
    <xsl:template match="tei:docTitle">

        <div class="title-part-main">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:titlePart">
        <p style="font-size: 1.5em; margin: 10px 0;"><xsl:apply-templates/></p>
    </xsl:template>
        <xsl:template match="tei:ab[@xml:space = 'preserve']">
        <pre class="ingredients"><xsl:apply-templates/></pre>
    </xsl:template>

    <xsl:template match="tei:p[@rend = 'procedure']">
        <div class="procedure">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    <xsl:template match="tei:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:hi[@rend='italic']">
        <i><xsl:apply-templates/></i>
    </xsl:template>
    
    
    
    

    
    

</xsl:stylesheet>
