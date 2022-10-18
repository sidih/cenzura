<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    exclude-result-prefixes="xs xi"
    version="2.0">
    
    <!-- preimenovanje in urejanje -->
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="root">
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Cenzura</title>
                    </titleStmt>
                    <publicationStmt>
                        <p>Publication Information</p>
                    </publicationStmt>
                    <sourceDesc>
                        <p>Information about the source</p>
                    </sourceDesc>
                </fileDesc>
            </teiHeader>
            <text>
                <body>
                    <xsl:for-each select="div">
                        <xsl:sort select="tokenize(@xml:id,'_')[2]"/>
                        <xsl:sort select="number(tokenize(@xml:id,'_')[3])"/>
                        <div xml:id="{@xml:id}">
                            <xsl:if test="head">
                                <head>
                                    <xsl:value-of select="head"/>
                                </head>
                            </xsl:if>
                            <xsl:for-each select="docAuthor">
                                <docAuthor>
                                    <xsl:value-of select="."/>
                                </docAuthor>
                            </xsl:for-each>
                            <xsl:if test="docDate">
                                <docDate>
                                    <xsl:for-each select="docDate">
                                        <xsl:attribute name="when">
                                            <xsl:call-template name="date-form"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="."/>
                                    </xsl:for-each>
                                </docDate>
                            </xsl:if>
                            <note type="idno">
                                <idno type="ARS">
                                    <xsl:value-of select="translate(@xml:id,'_','/')"/>
                                </idno>
                            </note>
                            <xsl:for-each select="lebel">
                                <label type="{@type}">
                                    <xsl:value-of select="."/>
                                </label>
                            </xsl:for-each>
                            <xsl:for-each select="stage">
                                <stage type="time">
                                    <date>
                                        <xsl:attribute name="when">
                                            <xsl:choose>
                                                <xsl:when test=" matches(.,'T00')">
                                                    <xsl:value-of select="substring-before(.,'T00')"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:call-template name="date-form"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:attribute>
                                        <xsl:value-of select="."/>
                                    </date>
                                </stage>
                            </xsl:for-each>
                            <xsl:for-each select="idno">
                                <note type="idno">
                                    <idno type="SLOGI">
                                        <xsl:value-of select="."/>
                                    </idno>
                                </note>
                            </xsl:for-each>
                            <xsl:for-each select="note">
                                <note>
                                    <xsl:value-of select="."/>
                                </note>
                            </xsl:for-each>
                        </div>
                        
                    </xsl:for-each>
                </body>
            </text>
        </TEI>
    </xsl:template>
    
    <xsl:template name="date-form">
        <xsl:value-of select="concat(tokenize(.,'\.')[3],'-',format-number(number(tokenize(.,'\.')[2]),'00'),'-',format-number(number(tokenize(.,'\.')[1]),'00'))"/>
    </xsl:template>
    
</xsl:stylesheet>