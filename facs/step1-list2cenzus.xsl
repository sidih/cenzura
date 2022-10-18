<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- izhodiščni list.xml -->
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="root">
        <root>
            <xsl:for-each select="object">
                <xsl:variable name="object-id" select="@path"/>
                <object path="{@path}">
                    <xsl:for-each select="document('../cenzura.xml')//tei:div">
                        <xsl:variable name="div-id">
                            <xsl:choose>
                                <xsl:when test=" matches(@xml:id,'N')">
                                    <xsl:value-of select="substring-before(@xml:id,'-')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="@xml:id"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:if test="$div-id = $object-id">
                            <idno>
                                <xsl:value-of select="@xml:id"/>
                            </idno>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:apply-templates/>
                </object>
            </xsl:for-each>
        </root>
    </xsl:template>
    
</xsl:stylesheet>