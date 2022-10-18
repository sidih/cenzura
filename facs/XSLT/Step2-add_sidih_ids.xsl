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
    
    <xsl:param name="lastSIDIH-entity-num">2169</xsl:param>
    <xsl:param name="lastSIDIHfileNumber">13164</xsl:param>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="object">
        <object path="{@path}" entityID="{position() + $lastSIDIH-entity-num}">
            <xsl:apply-templates/>
        </object>
    </xsl:template>
    
    <xsl:template match="facs">
        <xsl:variable name="numLevel">
            <xsl:number count="//facs" level="any"/>
        </xsl:variable>
        <xsl:variable name="numFacs">
            <xsl:number value="$numLevel"/>
        </xsl:variable>
        <facs fileID="{$numFacs + $lastSIDIHfileNumber}">
            <xsl:apply-templates/>
        </facs>
    </xsl:template>
    
</xsl:stylesheet>