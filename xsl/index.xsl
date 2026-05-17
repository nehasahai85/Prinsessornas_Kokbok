<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="1.0"
    exclude-result-prefixes="tei">
    
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title> Om | <xsl:value-of select="//tei:titleStmt/tei:title"/></title>
                <link rel="stylesheet" type="text/css" href="assets/css/style.css"/>
            </head>
            <body>
                <nav class="nav">
                    <ul>
                        <li><a href="index.html" class="active">Hem</a></li>
                        <li><a href="transkribering.html">Transkribering</a></li>
                        <li><a href="text.html">Text</a></li>
                        <li><a href="galleri.html">Galleri</a></li>
                        <li><a href="bladderlage.html">Läs-Läge</a></li>
                    </ul>
                </nav>
                <main class="content" style="text-align:left; max-width: 800px; margin: 40px auto; line-height: 1.6;">
                    
                    <h1 style="text-align:center;">
                        <xsl:value-of select="//tei:titleStmt/tei:title"/>
                    </h1>
                    
                    <section class="project-description">
                        <h2>Om projektet</h2>
                        <xsl:for-each select="//tei:encodingDesc/tei:projectDesc/tei:p">
                            <p><xsl:apply-templates/></p> 
                        </xsl:for-each>
                    </section>
                    
                    <xsl:if test="//tei:notesStmt/tei:note[@type='historical']">
                        <section class="magazine-history">
                            <h2><xsl:value-of select="//tei:notesStmt/tei:note[@type='historical']/tei:label"/></h2>
                            <xsl:for-each select="//tei:notesStmt/tei:note[@type='historical']/tei:p">
                                <p><xsl:value-of select="."/></p>
                            </xsl:for-each>
                        </section>
                    </xsl:if>
                    
                    <xsl:if test="//tei:text/tei:front/tei:div[@type='acknowledgements']">
                        <section class="acknowledgements">
                            <h2><xsl:value-of select="//tei:text/tei:front/tei:div[@type='acknowledgements']/tei:head"/></h2>
                            <ul>
                                <xsl:for-each select="//tei:text/tei:front/tei:div[@type='acknowledgements']/tei:list/tei:item">
                                    <li><xsl:value-of select="."/></li>
                                </xsl:for-each>
                            </ul>
                        </section>
                    </xsl:if>
                    
                    <hr/>
                    
                    <section class="credits">
                        <xsl:apply-templates select="//tei:titleStmt"/>
                        <xsl:apply-templates select="//tei:publicationStmt"/>
                    </section>
                </main>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="tei:titleStmt">
        <h3>Projektansvariga</h3>
        <ul>
            <xsl:for-each select="tei:respStmt">
                <li>
                    <strong><xsl:value-of select="tei:resp"/>:</strong> 
                    <xsl:for-each select="tei:persName">
                        <xsl:value-of select="tei:forename"/><xsl:text> </xsl:text><xsl:value-of select="tei:surname"/>
                        <xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
    
    <xsl:template match="tei:publicationStmt">
        <h3>Licens och Tillgänglighet</h3>
        <p><xsl:value-of select="tei:availability/tei:licence/tei:p[1]"/></p>
        <p><em>Distributör: <xsl:value-of select="tei:distributor"/></em></p>
    </xsl:template>
    <xsl:template match="tei:ref">
        <a href="{@target}" target="_blank" style="color: #0066cc; text-decoration: underline;">
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
</xsl:stylesheet>