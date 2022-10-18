<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!--  xmlns="http://www.tei-c.org/ns/1.0" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    -->
    
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="object">
        <xsl:variable name="objID" select="@path"/>
        <object path="{@path}">
            <metadata>
                <xsl:for-each select="document('../rrss_ms.xml')/tei:div/tei:msDesc[@xml:id=$objID]">
                    <xsl:variable name="glavni_naslov">
                        <xsl:for-each select="tei:msContents/tei:msItemStruct/tei:title[@type='editorial']">
                            <xsl:value-of select="text()"/>
                            <xsl:if test="position() != last()">
                                <xsl:text>: </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>
                    <title xml:lang="{tei:msContents/tei:msItemStruct/tei:title[@type='editorial'][1]/@xml:lang}">
                        <xsl:value-of select="normalize-space($glavni_naslov)"/>
                    </title>
                    <xsl:if test="tei:msContents/tei:msItemStruct/tei:title[@type='original']">
                        <xsl:variable name="alternativni_naslov">
                            <xsl:for-each select="tei:msContents/tei:msItemStruct/tei:title[@type='original']">
                                <xsl:value-of select="text()"/>
                                <xsl:if test="position() != last()">
                                    <xsl:text>: </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:variable>
                        <alternative xml:lang="{tei:msContents/tei:msItemStruct/tei:title[@type='original'][1]/@xml:lang}">
                            <xsl:value-of select="normalize-space($alternativni_naslov)"/>
                        </alternative>
                    </xsl:if>
                    <xsl:for-each select="tei:msContents/tei:msItemStruct/tei:author">
                        <xsl:choose>
                            <xsl:when test="@xml:lang">
                                <xsl:if test="@xml:lang = 'slv'">
                                    <creator>
                                        <xsl:value-of select="normalize-space(.)"/>
                                    </creator>
                                </xsl:if>
                            </xsl:when>
                            <xsl:otherwise>
                                <creator>
                                    <xsl:value-of select="normalize-space(.)"/>
                                </creator>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                    <xsl:if test="tei:history/tei:origin/tei:origDate">
                        <created>
                            <xsl:value-of select="normalize-space(tei:history/tei:origin/tei:origDate)"/>
                        </created>
                    </xsl:if>
                    <xsl:if test="string-length(tei:msIdentifier/tei:country) gt 0">
                        <spatial>
                            <xsl:value-of select="normalize-space(tei:msIdentifier/tei:country)"/>
                        </spatial>
                    </xsl:if>
                    <xsl:if test="string-length(tei:msIdentifier/tei:settlement) gt 0">
                        <spatial>
                            <xsl:value-of select="normalize-space(tei:msIdentifier/tei:settlement)"/>
                        </spatial>
                    </xsl:if>
                    <xsl:if test="string-length(tei:msIdentifier/tei:repository) gt 0">
                        <provenance>
                            <xsl:value-of select="normalize-space(tei:msIdentifier/tei:repository)"/>
                        </provenance>
                    </xsl:if>
                    <xsl:if test="string-length(tei:msIdentifier/tei:idno) gt 0">
                        <identifier>
                            <xsl:value-of select="normalize-space(tei:msIdentifier/tei:idno)"/>
                        </identifier>
                    </xsl:if>
                    <identifier>
                        <xsl:value-of select="$objID"/>
                    </identifier>
                    <xsl:if test="string-length(tei:msContents/tei:summary) gt 0">
                        <xsl:variable name="opis">
                            <xsl:for-each select="tei:msContents/tei:summary//text()">
                                <xsl:value-of select="."/>
                                <xsl:if test="position() != last()">
                                    <xsl:text> </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:variable>
                        <description xml:lang="slv">
                            <xsl:value-of select="normalize-space($opis)"/>
                        </description>
                    </xsl:if>
                    <xsl:if test="string-length(tei:physDesc) gt 0">
                        <xsl:variable name="opis">
                            <xsl:for-each select="tei:physDesc//text()">
                                <xsl:value-of select="."/>
                                <xsl:if test="position() != last()">
                                    <xsl:text> || </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:variable>
                        <medium>
                            <xsl:value-of select="normalize-space($opis)"/>
                        </medium>
                    </xsl:if>
                    
                </xsl:for-each>
            </metadata>
            <xsl:apply-templates/>
        </object>
    </xsl:template>
    
</xsl:stylesheet>