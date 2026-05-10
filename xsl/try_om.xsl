<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="1.0"
    exclude-result-prefixes="tei">
    
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title> Om | Prinsessornas Kakbok</title>
                <link rel="stylesheet" type="text/css" href="assets/css/style.css"/>
           
            </head>
            <body>
                <nav class="nav">
                    <ul>
                        <li><a href="index.html" class="active">OM</a></li>
                        <li><a href="transkribering.html">TRANSKRIBERING</a></li>
                        <li><a href="text.html">TEXT</a></li>
                        <li><a href="galleri.html">GALLERI</a></li>
                        <li><a href="bladderlage.html">BLÄDDERLÄGE</a></li>
                    </ul>
                </nav>
                <main class="content" style="text-align:left; max-width: 800px; margin: 40px auto; line-height: 1.6;">
                    
                    <!-- Main Title from XML -->
                    <h1 style="text-align:center;">
                        <xsl:value-of select="//tei:titleStmt/tei:title"/>
                    </h1>
                    
                    <section class="project-description">
                        <h2>Bakgrund</h2>
                        <p>Detta digitaliseringsprojekt har utförts inom ramen för kursen <strong>Digitalisering för bevarande och tillgängliggörande</strong> vid Masterprogrammet i biblioteks- och informationsvetenskap vid Högskolan i Borås våren 2026.
                        </p>
                        
                        <p>
                            Materialet består av <em>Prinsessornas kakbok 1960</em>, utvald i samråd med <strong>KvinnSam – nationellt bibliotek för genusforskning vid Göteborgs universitetsbibliotek</strong>. 
                        </p>
                        
                        <h2>Tack</h2>
                        <p>Vi vill tacka följande personer och institutioner som möjliggjort projektet:</p>
                        <ul>
                            <li><strong>KvinnSam – nationellt bibliotek för genusforskning vid Göteborgs universitetsbibliotek</strong></li>
                            <li><strong>Mikael Gunnarsson</strong>, för handledning och expertis.</li>
                            <li><strong>Wout Dillen</strong>, för den tekniska mallen som använts för webbplatsen.</li>
                        </ul>
                        
                        <p>
                            Materialet har bearbetats och publicerats av <strong>Neha Sharma, Diblik Rabia och Anna Maria Hedin</strong>. 
                            Referera till filerna <em>Recipe_tei.xml</em> och <em>try_om.xsl</em> för teknisk dokumentation.
                        </p>
                        
                    </section>
                </main>
            </body>
        </html>
    </xsl:template>
    
    <!-- Template to display the credits/responsibility statement from the XML header -->
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
    
    <!-- Template for publication and license details -->
    <xsl:template match="tei:publicationStmt">
        <h3>Licens och Tillgänglighet</h3>
        <p><xsl:value-of select="tei:availability/tei:licence/tei:p[1]"/></p>
        <p><em>Distributör: <xsl:value-of select="tei:distributor"/></em></p>
    </xsl:template>
    
</xsl:stylesheet>

                           