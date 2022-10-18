<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    
    <xsl:param name="iiif_basic_id">entity|2001-3000|</xsl:param>
    
    <xsl:template match="root">
        <xsl:result-document href="RRSS-all_facsimiles-part_2.xml">
            <TEI xmlns="http://www.tei-c.org/ns/1.0">
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>RRSS facsimiles</title>
                        </titleStmt>
                        <publicationStmt>
                            <p>If that’s okay, use them.</p>
                        </publicationStmt>
                        <sourceDesc>
                            <p></p>
                        </sourceDesc>
                    </fileDesc>
                </teiHeader>
                <xsl:for-each select="object">
                    <facsimile xml:id="{@path}">
                        <xsl:variable name="entityID" select="@entityID"/>
                        <xsl:for-each select="facs">
                            <graphic url="{concat($iiif_basic_id,$entityID,'|',.)}"/>
                        </xsl:for-each>
                    </facsimile>
                </xsl:for-each>
                <text>
                    <body>
                        <p></p>
                    </body>
                </text>
            </TEI>
         </xsl:result-document>
    </xsl:template>
    
</xsl:stylesheet>