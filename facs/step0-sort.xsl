<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <!-- tabelam dodam atribute -->
    <xsl:output method="xml" indent="no"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="root">
        <root>
            <xsl:for-each select="object">
                <xsl:sort select="tokenize(@path,'_')[2]"/>
                <xsl:sort select="number(tokenize(@path,'_')[3])"/>
                <object path="{@path}">
                    <xsl:apply-templates/>
                </object>
            </xsl:for-each>
        </root>
    </xsl:template>
    
</xsl:stylesheet>