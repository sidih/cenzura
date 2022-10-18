<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    exclude-result-prefixes="xs xi tei"
    version="2.0">
    
    <!-- izhodiščni census.xml -->
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:body">
        <body>
            <xsl:for-each select="tei:div">
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
                <div xml:id="{@xml:id}">
                    <xsl:for-each select="document('list.xml')//object">
                        <xsl:variable name="object-id" select="@path"/>
                        <xsl:if test="$object-id = $div-id">
                            <xsl:attribute name="facs">
                                <xsl:value-of select="@path"/>
                            </xsl:attribute>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:apply-templates/>
                </div>
            </xsl:for-each>
        </body>
    </xsl:template>
    
</xsl:stylesheet>