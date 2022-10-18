<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    exclude-result-prefixes="xs xi"
    version="2.0">
    
    <!-- preimenovanje in urejanje -->
    <xsl:output method="xml" indent="no"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="row">
        <div xml:id="{translate(Ime,'/','_')}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="Ime">
        
    </xsl:template>
    
    <xsl:template match="Datum">
        <docDate>
            <xsl:value-of select="translate(.,' ','')"/>
        </docDate>
    </xsl:template>
    
    <xsl:template match="Uprizorjeno">
        <stage type="time">
            <xsl:value-of select="translate(.,' ','')"/>
        </stage>
    </xsl:template>
    
    <xsl:template match="Naslov">
        <head>
            <xsl:value-of select="normalize-space(.)"/>
        </head>
    </xsl:template>
    
    <xsl:template match="Avtor">
        <xsl:for-each select="tokenize(.,'/')">
            <docAuthor>
                <xsl:value-of select="normalize-space(.)"/>
            </docAuthor>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Sprejeto">
        <xsl:if test="string-length(.) gt 0">
            <lebel type="accepted">
                <xsl:value-of select="normalize-space(.)"/>
            </lebel>
        </xsl:if>
    </xsl:template>
   
    <xsl:template match="Zahtevek">
        <xsl:if test="string-length(.) gt 0">
            <lebel type="claim">
                <xsl:value-of select="normalize-space(.)"/>
            </lebel>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="Morala">
        <xsl:if test="string-length(.) gt 0">
            <lebel type="morality">
                <xsl:value-of select="normalize-space(.)"/>
            </lebel>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="Cerkev">
        <xsl:if test="string-length(.) gt 0">
            <lebel type="church">
                <xsl:value-of select="normalize-space(.)"/>
            </lebel>
        </xsl:if>
    </xsl:template>
   
    <xsl:template match="Državne_institucije">
        <xsl:if test="string-length(.) gt 0">
            <lebel type="state_institutions">
                <xsl:value-of select="normalize-space(.)"/>
            </lebel>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="Politika">
        <xsl:if test="string-length(.) gt 0">
            <lebel type="politics">
                <xsl:value-of select="normalize-space(.)"/>
            </lebel>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="Signatura_v_SLOGI__Slovenski_gledališki_inštitut_">
        <xsl:if test="string-length(.) gt 0">
            <idno type="SLOGI">
                <xsl:value-of select="normalize-space(.)"/>
            </idno>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="Faksimile">
        <xsl:if test="string-length(.) gt 0">
            <lebel type="facs">
                <xsl:value-of select="normalize-space(.)"/>
            </lebel>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="Opomba">
        <xsl:if test="string-length(.) gt 0">
            <note>
                <xsl:value-of select="normalize-space(.)"/>
            </note>
        </xsl:if>
    </xsl:template>
    
    
</xsl:stylesheet>