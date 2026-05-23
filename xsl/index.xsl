<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="1.0"
    exclude-result-prefixes="tei">
    
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title>Om | <xsl:value-of select="//tei:titleStmt/tei:title"/></title>
                <link rel="stylesheet" type="text/css" href="assets/css/style.css"/>
            </head>
            <body class="body">
                <nav class="nav">
                    <ul>
                        <li><a href="index.html" class="active">Hem</a></li>
                        <li><a href="transkribering.html">Transkribering</a></li>
                        <li><a href="text.html">Text</a></li>
                        <li><a href="galleri.html">Galleri</a></li>
                        <li><a href="bladderlage.html">Läsläge</a></li>
                    </ul>
                </nav>
                
                <main class="content" style="max-width: 1100px; margin: 40px auto; padding: 30px; font-family: 'Times New Roman', serif; background-color: #fdfdfd; box-shadow: 0 4px 20px rgba(0,0,0,0.05); border-radius: 8px; color: #000000;">
                    
                    <div style="display: flex; gap: 60px; align-items: flex-start;">
                        
                        <xsl:if test="//tei:text/tei:front/tei:div[@type='front-cover']">
                            <div class="front-cover-sidebar" style="flex: 0 0 380px; text-align: center; background-color: #fcfbf7; padding: 25px; border: 1px solid #dfd8ca; box-shadow: 0 6px 18px rgba(0,0,0,0.08); border-radius: 4px; position: sticky; top: 80px;">
                                
                                <h2 style="margin: 0 0 20px 0; font-size: 2.2em; font-weight: bold; color: #000000; letter-spacing: 3px; text-transform: uppercase;">
                                    <xsl:value-of select="normalize-space(//tei:text/tei:front/tei:div[@type='front-cover']/tei:p[@rend='cover-title-top']/text())"/>
                                </h2>
                                
                                <div class="main-illustration" style="width: 100%; margin: 0 auto;">
                                    <img src="assets/img/00_Cover.jpg" alt="Prinsessornas Kakbok Omslag" style="width: 100%; height: auto; display: block; border: 1px solid #dcd6cd; box-shadow: 0 4px 12px rgba(0,0,0,0.15);" />
                                </div>
                                
                            </div>
                        </xsl:if>
                        
                        <div class="main-text-content" style="flex: 1; font-size: 1.15em; line-height: 1.7; color: #000000; text-align: left;">
                            
                            <section class="about-section" style="margin-bottom: 45px;">
                                <h1 style="margin-top: 0; font-size: 2.5em; border-bottom: 3px solid #000000; padding-bottom: 10px; color: #000000; font-weight: bold;">Om projektet</h1>
                                <xsl:for-each select="//tei:encodingDesc/tei:projectDesc/tei:p">
                                    <p style="margin: 16px 0; text-align: justify; color: #000000;"><xsl:apply-templates/></p> 
                                </xsl:for-each>
                            </section>
                            
                            <xsl:if test="//tei:notesStmt/tei:note[@type='historical']">
                                <section class="history-section" style="margin-bottom: 45px;">
                                    <h2 style="font-size: 1.8em; border-bottom: 1px solid #dfd8ca; padding-bottom: 8px; color: #000000;"><xsl:value-of select="//tei:notesStmt/tei:note[@type='historical']/tei:label"/></h2>
                                    <xsl:for-each select="//tei:notesStmt/tei:note[@type='historical']/tei:p">
                                        <p style="margin: 16px 0; text-align: justify; color: #000000;"><xsl:value-of select="."/></p>
                                    </xsl:for-each>
                                </section>
                            </xsl:if>
                            
                            <xsl:if test="//tei:text/tei:front/tei:div[@type='acknowledgements']">
                                <section class="acknowledgements-section" style="margin-bottom: 45px;">
                                    <h2 style="font-size: 1.8em; border-bottom: 1px solid #dfd8ca; padding-bottom: 8px; color: #000000;"><xsl:value-of select="//tei:text/tei:front/tei:div[@type='acknowledgements']/tei:head"/></h2>
                                    <ul style="padding-left: 20px; margin: 16px 0; list-style-position: outside; text-align: left; color: #000000;">
                                        <xsl:for-each select="//tei:text/tei:front/tei:div[@type='acknowledgements']/tei:list/tei:item">
                                            <li style="margin-bottom: 10px; padding-left: 5px;"><xsl:value-of select="."/></li>
                                        </xsl:for-each>
                                    </ul>
                                </section>
                            </xsl:if>
                            
                        </div>
                    </div>
                    
                    <hr style="border: 0; border-top: 1px solid #dfd8ca; margin: 50px 0 25px 0;"/>
                    <section class="credits-footer" style="font-size: 0.95em; color: #000000; line-height: 1.6; text-align: left;">
                        <xsl:apply-templates select="//tei:titleStmt"/>
                        <xsl:apply-templates select="//tei:publicationStmt"/>
                    </section>
                    
                </main>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="tei:titleStmt">
        <h3 style="color: #000000; font-size: 1.2em; margin-bottom: 8px; text-align: left; font-weight: bold;">Digitalisering och tillgängliggörande</h3>
        <div style="text-align: left; margin-bottom: 25px; color: #000000;">
            <xsl:for-each select="tei:respStmt[@xml:id='digitalisering']">
                <p style="margin: 6px 0; font-size: 1.05em;">
                    <strong><xsl:value-of select="tei:resp"/>: </strong> 
                    <xsl:for-each select="tei:persName">
                        <xsl:value-of select="tei:forename"/><xsl:text> </xsl:text><xsl:value-of select="tei:surname"/>
                        <xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each>
                </p>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:publicationStmt">
        <h3 style="color: #000000; font-size: 1.2em; margin-bottom: 8px; text-align: left; font-weight: bold;">Licens och Tillgänglighet</h3>
        <div style="text-align: left; color: #000000;">
            <xsl:for-each select="tei:availability/tei:licence/tei:p">
                <p style="margin: 6px 0; font-size: 1.05em;"><xsl:apply-templates/></p>
            </xsl:for-each>
            <p style="margin-top: 12px; font-style: italic;">Distributör: <xsl:value-of select="tei:distributor"/></p>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:ref">
        <a href="{@target}" target="_blank" style="color: #000000; text-decoration: underline; font-weight: bold;">
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    <xsl:template match="tei:hi[@rend='bold']">
        <strong style="color: #000000; font-weight: bold;"><xsl:apply-templates/></strong>
    </xsl:template>
</xsl:stylesheet>