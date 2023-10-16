<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:tei="http://www.tei-c.org/ns/1.0"
   xmlns:teidocx="http://www.tei-c.org/ns/teidocx/1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="tei html teidocx xs"
   version="2.0">

   <xsl:import href="../../../../pub-XSLT/Stylesheets/html5-foundation6-chs/to.xsl"/>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>
         <p>TEI stylesheet for making HTML5 output (Zurb Foundation 6 http://foundation.zurb.com/sites/docs/).</p>
         <p>This software is dual-licensed:
            
            1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
            Unported License http://creativecommons.org/licenses/by-sa/3.0/ 
            
            2. http://www.opensource.org/licenses/BSD-2-Clause
            
            
            
            Redistribution and use in source and binary forms, with or without
            modification, are permitted provided that the following conditions are
            met:
            
            * Redistributions of source code must retain the above copyright
            notice, this list of conditions and the following disclaimer.
            
            * Redistributions in binary form must reproduce the above copyright
            notice, this list of conditions and the following disclaimer in the
            documentation and/or other materials provided with the distribution.
            
            This software is provided by the copyright holders and contributors
            "as is" and any express or implied warranties, including, but not
            limited to, the implied warranties of merchantability and fitness for
            a particular purpose are disclaimed. In no event shall the copyright
            holder or contributors be liable for any direct, indirect, incidental,
            special, exemplary, or consequential damages (including, but not
            limited to, procurement of substitute goods or services; loss of use,
            data, or profits; or business interruption) however caused and on any
            theory of liability, whether in contract, strict liability, or tort
            (including negligence or otherwise) arising in any way out of the use
            of this software, even if advised of the possibility of such damage.
         </p>
         <p>Andrej Pančur, Institute for Contemporary History</p>
         <p>Copyright: 2013, TEI Consortium</p>
      </desc>
   </doc>
  
   <!-- Uredi parametre v skladu z dodatnimi zahtevami za pretvorbo te publikacije: -->
   <!-- ../../../  -->
   <!--  -->
   <xsl:param name="path-general">https://www2.sistory.si/publikacije/</xsl:param>
   
   <xsl:param name="localWebsite">false</xsl:param>
   
   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/to.xsl -->
   <xsl:param name="outputDir">docs_v3/</xsl:param>
   
   <xsl:param name="homeLabel">Cenzura</xsl:param>
   <xsl:param name="homeURL">https://sidih.github.io/cenzura/</xsl:param>
   
   <xsl:param name="splitLevel">0</xsl:param>
   
   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/my-html_param.xsl -->
   <xsl:param name="title-bar-sticky">false</xsl:param>
   
   <xsl:param name="chapterAsSIstoryPublications">false</xsl:param>
   
   <!-- odstranim pri spodnjih param true -->
   <xsl:param name="numberFigures"></xsl:param>
   <xsl:param name="numberFrontTables"></xsl:param>
   <xsl:param name="numberHeadings"></xsl:param>
   <xsl:param name="numberParagraphs"></xsl:param>
   <xsl:param name="numberTables"></xsl:param>
   
   <!-- V html/head izpisani metapodatki -->
   <xsl:param name="description"></xsl:param>
   <xsl:param name="keywords"></xsl:param>
   <xsl:param name="title"></xsl:param>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Novo ime za glavno vsebino (glavna navigacija)</desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="nav-body-head">
      <xsl:param name="thisLanguage"/>
      <xsl:text>Dokumenti</xsl:text>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Novo ime za indekse</desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="nav-index-head">
      <xsl:param name="thisLanguage"/>
      <xsl:text>Filtri</xsl:text>
   </xsl:template>
   
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="divGen-main-content">
      <xsl:param name="thisLanguage"/>
      <!-- kolofon CIP -->
      <xsl:if test="self::tei:divGen[@type='cip']">
         <xsl:apply-templates select="ancestor::tei:TEI/tei:teiHeader/tei:fileDesc" mode="kolofon"/>
      </xsl:if>
      <!-- TEI kolofon -->
      <xsl:if test="self::tei:divGen[@type='teiHeader']">
         <xsl:apply-templates select="ancestor::tei:TEI/tei:teiHeader"/>
      </xsl:if>
      <!-- kazalo vsebine toc -->
      <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='toc'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='toc']">
         <xsl:call-template name="mainTOC"/>
      </xsl:if>
      <!-- kazalo slik -->
      <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='images'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='images']">
         <xsl:call-template name="images"/>
      </xsl:if>
      <!-- kazalo grafikonov -->
      <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='charts'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='charts']">
         <xsl:call-template name="charts"/>
      </xsl:if>
      
      <!-- prazen divGen, v katerem lahko naknadno poljubno procesiramo vsebino -->
      <xsl:if test="self::tei:divGen[@type='content']">
         <xsl:call-template name="divGen-process-content"/>
      </xsl:if>
      
      <!-- kazalo tabel -->
      <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='tables'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='tables']">
         <xsl:call-template name="tables"/>
      </xsl:if>
      <!-- kazalo vsebine toc, ki izpiše samo glavne naslove poglavij, skupaj z imeni avtorjev poglavij -->
      <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='titleAuthor'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='titleAuthor']">
         <xsl:call-template name="TOC-title-author"/>
      </xsl:if>
      <!-- kazalo vsebine toc, ki izpiše samo naslove poglavij, kjer ima div atributa type in xml:id -->
      <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='titleType'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='titleType']">
         <xsl:call-template name="TOC-title-type"/>
      </xsl:if>
      <!-- seznam (indeks) oseb -->
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='persons'] | self::tei:divGen[@type='index'][tokenize(@xml:id,'-')[last()]='persons']">
         <xsl:call-template name="persons"/>
      </xsl:if>
      <!-- seznam (indeks) krajev -->
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='places'] | self::tei:divGen[@type='index'][tokenize(@xml:id,'-')[last()]='places']">
         <xsl:call-template name="places"/>
      </xsl:if>
      <!-- seznam (indeks) organizacij -->
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='organizations'] | self::tei:divGen[@type='index'][tokenize(@xml:id,'-')[last()]='organizations']">
         <xsl:call-template name="organizations"/>
      </xsl:if>
      <!-- iskalnik -->
      <xsl:if test="self::tei:divGen[@type='search']">
         <xsl:call-template name="search"/>
      </xsl:if>
      <!-- DODAL SPODNJO SAMO ZA TO PRETVORBO! -->
      <!-- za generiranje datateble -->
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='main']">
         <xsl:call-template name="datatables-main"/>
      </xsl:if>
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='provenience']">
         <xsl:call-template name="datatables-provenience"/>
      </xsl:if>
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='genre']">
         <xsl:call-template name="datatables-genre"/>
      </xsl:if>
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='type']">
         <xsl:call-template name="datatables-type"/>
      </xsl:if>
      <!-- genre2, Zvrstna opredelitev, row[5] -->
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='genre2']">
         <xsl:call-template name="datatables-genre2"/>
      </xsl:if>
      <!-- year, Leto (ali šolsko leto) uprizoritve, row[6] -->
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='year']">
         <xsl:call-template name="datatables-year"/>
      </xsl:if>
      <!-- opportunity, Priložnost uprizoritve, row[7] -->
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='opportunity']">
         <xsl:call-template name="datatables-opportunity"/>
      </xsl:if>
      <!-- stage, Kraj uprizoritve drame, row[12] -->
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='stage']">
         <xsl:call-template name="datatables-stage"/>
      </xsl:if>
      <!-- actors, Kdo jo je igral?, row[13] -->
      <xsl:if test="self::tei:divGen[@type='index'][@xml:id='actors']">
         <xsl:call-template name="datatables-actors"/>
      </xsl:if>
   </xsl:template>
   
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>V css in javascript Hook dodam imageViewer</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="cssHook">
      <xsl:if test="$title-bar-sticky = 'true'">
         <xsl:value-of select="concat($path-general,'themes/css/foundation/6/sistory-sticky_title_bar.css')"/>
      </xsl:if>
      <link href="https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.min.css" rel="stylesheet" type="text/css" />
      <link href="{concat($path-general,'themes/plugin/TipueSearch/6.1/tipuesearch/css/normalize.css')}" rel="stylesheet" type="text/css" />
      <link href="{concat($path-general,'themes/css/plugin/TipueSearch/6.1/my-tipuesearch.css')}" rel="stylesheet" type="text/css" />
      <!-- dodan imageViewer -->
      <link href="{concat($path-general,'themes/plugin/ImageViewer/1.1.3/imageviewer.css')}" rel="stylesheet" type="text/css" />
      <!-- dodan openseadragon -->
      <link href="{concat($path-general,'themes/library/openseadragon/2.4.2/openseadragon.css')}" rel="stylesheet" type="text/css" />
   </xsl:template>
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>[html] Hook where extra Javascript functions can be defined</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="javascriptHook">
      <script src="{concat($path-general,'themes/foundation/6/js/vendor/jquery.js')}"></script>
      <!-- za highcharts -->
      <xsl:if test="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']]">
         <xsl:variable name="jsfile" select="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']][1]/tei:graphic[@mimeType = 'application/javascript']/@url"/>
         <xsl:variable name="chart-jsfile" select="document($jsfile)/html/body/script[1]/@src"/>
         <script src="{$chart-jsfile[1]}"></script>
      </xsl:if>
      <!-- za back-to-top in highcharts je drugače potrebno dati jquery, vendar sedaj ne rabim dodajati jquery kodo,
         ker je že vsebovana zgoraj -->
      <!-- dodan imageViewer -->
      <script src="{concat($path-general,'themes/plugin/ImageViewer/1.1.3/imageviewer.js')}"></script>
      <!-- dodan openseadragon -->
      <script src="{concat($path-general,'themes/library/openseadragon/2.4.2/openseadragon.min.js')}"></script>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Dokler ne uredim faksimilov, začasno izbrišem procesiranje slik</desc>
   </doc>
   <xsl:template match="tei:figure[ancestor::tei:body][not(tei:graphic)]">
      
   </xsl:template>
   <!--<doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>samo slika naslovnice ali pa galerija slik</desc>
   </doc>
   <xsl:template match="tei:figure[ancestor::tei:body][tei:graphic]">
      <xsl:choose>
         <!-\- začasno tisti, kjer so slike na Emoncu: ko urediš, briši head -\->
         <xsl:when test="tei:head">
            <xsl:choose>
               <xsl:when test="tei:graphic[2]">
                  <xsl:if test="not(preceding-sibling::*[1][self::tei:figure])">
                     <style>
                        #image-gallery {
                        width: 100%;
                        position: relative;
                        height: 650px;
                        background: #000;
                        }
                        #image-gallery .image-container {
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        bottom: 50px;
                        }
                        #image-gallery .prev,
                        #image-gallery .next {
                        position: absolute;
                        height: 32px;
                        margin-top: -66px;
                        top: 50%;
                        }
                        #image-gallery .prev {
                        left: 20px;
                        }
                        #image-gallery .next {
                        right: 20px;
                        cursor: pointer;
                        }
                        #image-gallery .footer-info {
                        position: absolute;
                        height: 50px;
                        width: 100%;
                        left: 0;
                        bottom: 0;
                        line-height: 50px;
                        font-size: 24px;
                        text-align: center;
                        color: white;
                        border-top: 1px solid #FFF;
                        }
                     </style>
                  </xsl:if>
                  <xsl:if test="preceding-sibling::*[1][self::tei:figure]">
                     <style>
                        #image-gallery2 {
                        width: 100%;
                        position: relative;
                        height: 650px;
                        background: #000;
                        }
                        #image-gallery2 .image-container {
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        bottom: 50px;
                        }
                        #image-gallery2 .prev,
                        #image-gallery2 .next {
                        position: absolute;
                        height: 32px;
                        margin-top: -66px;
                        top: 50%;
                        }
                        #image-gallery2 .prev {
                        left: 20px;
                        }
                        #image-gallery2 .next {
                        right: 20px;
                        cursor: pointer;
                        }
                        #image-gallery2 .footer-info {
                        position: absolute;
                        height: 50px;
                        width: 100%;
                        left: 0;
                        bottom: 0;
                        line-height: 50px;
                        font-size: 24px;
                        text-align: center;
                        color: white;
                        border-top: 1px solid #FFF;
                        }
                     </style>
                  </xsl:if>
                  <div id="image-gallery{if (preceding-sibling::*[1][self::tei:figure]) then '2' else ''}">
                     <div class="image-container"></div>
                     <img src="{concat($path-general,'themes/plugin/ImageViewer/1.1.3/images/left.svg')}" class="prev"/>
                     <img src="{concat($path-general,'themes/plugin/ImageViewer/1.1.3/images/right.svg')}"  class="next"/>
                     <div class="footer-info">
                        <span class="current"></span>/<span class="total"></span>
                     </div>
                  </div>   
                  <script type="text/javascript">
                     $(function () {
                     var images = [
                     <xsl:for-each select="tei:graphic">
                        <xsl:variable name="image"
                           select="substring-before(tokenize(@url,'\|')[last()], '/info.json')"/>
                        <xsl:variable name="image-small-iiif" select="concat('https://www2.sistory.si/publikacije/jezuitika/facs/',parent::tei:figure/tei:head,'-small/',$image)"/>
                        <xsl:variable name="image-large-iiif" select="concat('https://www2.sistory.si/publikacije/jezuitika/facs/',parent::tei:figure/tei:head,'/',$image)"/>
                        <xsl:text>{
                 small : '</xsl:text><xsl:value-of select="$image-small-iiif"/><xsl:text>',
                 big : '</xsl:text><xsl:value-of select="$image-large-iiif"/><xsl:text>'
               }</xsl:text><xsl:if test="position() != last()">
                  <xsl:text>,</xsl:text>
               </xsl:if>
                     </xsl:for-each>
                     <xsl:text>];</xsl:text>
                     
                     var curImageIdx = 1,
                     total = images.length;
                     var wrapper = $('#image-gallery<xsl:value-of select="if (preceding-sibling::*[1][self::tei:figure]) then '2' else ''"/>'),
                     curSpan = wrapper.find('.current');
                     var viewer = ImageViewer(wrapper.find('.image-container'));
                     
                     //display total count
                     wrapper.find('.total').html(total);
                     
                     <xsl:text disable-output-escaping="yes"><![CDATA[function showImage(){
               var imgObj = images[curImageIdx - 1];
               viewer.load(imgObj.small, imgObj.big);
               curSpan.html(curImageIdx);
               }
               
               wrapper.find('.next').click(function(){
               curImageIdx++;
               if(curImageIdx > total) curImageIdx = 1;
               showImage();
               });
               
               wrapper.find('.prev').click(function(){
               curImageIdx-\-;
               if(curImageIdx < 0) curImageIdx = total;
               showImage();
               });
               
               //initially show image
               showImage();
               });]]></xsl:text>
                  </script>
                  <br/>
                  <br/>
               </xsl:when>
               <xsl:otherwise>
                  <!-\- v resnici samo ena slika -\->
                  <xsl:for-each select="tei:graphic">
                     <xsl:variable name="image"
                        select="substring-before(tokenize(@url,'\|')[last()], '/info.json')"/>
                     <xsl:variable name="image-small-iiif" select="concat('https://www2.sistory.si/publikacije/jezuitika/facs/',parent::tei:figure/tei:head,'-small/',$image)"/>
                     <xsl:variable name="image-large-iiif" select="concat('https://www2.sistory.si/publikacije/jezuitika/facs/',parent::tei:figure/tei:head,'/',$image)"/>
                     <style>
                        #image-gallery {
                        width: 100%;
                        position: relative;
                        height: 650px;
                        background: #000;
                        }
                        #image-gallery .image-container {
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        bottom: 50px;
                        }
                     </style>
                     <div id="image-gallery">
                        <div class="image-container text-center">
                           <img class="imageviewer" style="height:600px;" src="{$image-small-iiif}" data-high-res-src="{$image-large-iiif}"/>
                        </div>
                     </div>
                     <br/>
                     <br/>
                  </xsl:for-each>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <!-\- redno procesiranje slik iz IIIF -\->
         <xsl:otherwise>
            <br/>
            <div id="{@xml:id}"
               class="openseadragon">
               <script type="text/javascript">
                  OpenSeadragon({
                  id:            "<xsl:value-of select="@xml:id"/>",
                  prefixUrl:     "https://openseadragon.github.io/openseadragon/images/",
                  showNavigator:  true,
                  sequenceMode:  true,
                  <xsl:if test="tei:graphic[2]">
                     <xsl:text>showReferenceStrip: true,</xsl:text>
                  </xsl:if>
                  tileSources:   [
                  <xsl:for-each select="tei:graphic">
                     <xsl:value-of select="concat('&quot;',@url,'&quot;')"/>
                     <xsl:if test="position() != last()">
                        <xsl:text>,&#xA;</xsl:text>
                     </xsl:if>
                  </xsl:for-each>
                  ]
                  });
               </script>
            </div>
            <br/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>-->
   
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>Dodam zaključni javascript za ImageViewer</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="bodyEndHook">
      <script type="text/javascript">
         $(function () {
         $('.imageviewer').ImageViewer();
         });
         
         <!--$(function () {
         var viewer = ImageViewer();
         $('.imageviewer').click(function () {
         var imgSrc = this.src,
         highResolutionImage = $(this).data('high-res-src');
         viewer.show(imgSrc, highResolutionImage);
         });
         });-->
      </script>
      <script src="{concat($path-general,'themes/foundation/6/js/vendor/what-input.js')}"></script>
      <script src="{concat($path-general,'themes/foundation/6/js/vendor/foundation.min.js')}"></script>
      <script src="{concat($path-general,'themes/foundation/6/js/app.js')}"></script>
      <!-- back-to-top -->
      <script src="{concat($path-general,'themes/js/plugin/back-to-top/back-to-top.js')}"></script>
   </xsl:template>
   
   
   <!-- Novo procesiranje vsebine v body//div -->
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:head[ancestor::tei:body][parent::tei:div[parent::tei:body]]">
      <div style="line-height: 25px; margin-bottom: 3px; display: flex; flex-direction: row;">
         <div style="width: 200px;">Naslov dela:</div>
         <div style="flex: 1;">
            <xsl:value-of select="normalize-space(.)"/>
         </div>
      </div>
   </xsl:template>
  
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:docAuthor[ancestor::tei:body]">
      <div style="line-height: 25px; margin-bottom: 3px; display: flex; flex-direction: row;">
         <div style="width: 200px;">Avtor cenzurirane drame:</div>
         <div style="flex: 1;">
            <xsl:value-of select="normalize-space(.)"/>
         </div>
      </div>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:docDate[ancestor::tei:body]">
      <div style="line-height: 25px; margin-bottom: 3px; display: flex; flex-direction: row;">
         <div style="width: 200px;">Datum dokumenta:</div>
         <div style="flex: 1;">
            <xsl:value-of select="normalize-space(.)"/>
         </div>
      </div>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:note[ancestor::tei:body][@type='idno'][tei:idno[@type='ARS']]">
      <div style="line-height: 25px; margin-bottom: 3px; display: flex; flex-direction: row;">
         <div style="width: 200px;">Signatura ARS:</div>
         <div style="flex: 1;">
            <xsl:value-of select="normalize-space(tei:idno)"/>
         </div>
      </div>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:note[ancestor::tei:body][@type='idno'][tei:idno[@type='SLOGI']]">
      <div style="line-height: 25px; margin-bottom: 3px; display: flex; flex-direction: row;">
         <div style="width: 200px;">Signatura izvoda SLOGI:</div>
         <div style="flex: 1;">
            <xsl:value-of select="normalize-space(tei:idno)"/>
         </div>
      </div>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:stage[ancestor::tei:body][@type='time']">
      <div style="line-height: 25px; margin-bottom: 3px; display: flex; flex-direction: row;">
         <div style="width: 200px;">Datum uprizoritve:</div>
         <div style="flex: 1;">
            <xsl:value-of select="normalize-space(tei:date)"/>
         </div>
      </div>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:label[ancestor::tei:body]">
      <div style="line-height: 25px; margin-bottom: 3px; display: flex; flex-direction: row;" id="{@xml:id}">
         <div style="width: 200px;">
            <xsl:choose>
               <xsl:when test="@type='accepted'">Cenzura:</xsl:when>
               <xsl:when test="@type='claim'">Zahtevek:</xsl:when>
               <xsl:when test="@type='morality'">Področje cenzure - morala:</xsl:when>
               <xsl:when test="@type='church'">Področje cenzure - religija:</xsl:when>
               <xsl:when test="@type='state_institutions'">Področje cenzure - državne institucije:</xsl:when>
               <xsl:when test="@type='politics'">Področje cenzure - politika:</xsl:when>
               <xsl:when test="@type='facs'">Faksimile:</xsl:when>
            </xsl:choose>
         </div>
         <div style="flex: 1;">
            <xsl:value-of select="normalize-space(.)"/>
         </div>
      </div>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="datatables-main">
      <link rel="stylesheet" type="text/css" href="{if ($localWebsite='true') then 'datatables.min.css' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.css'}" />
      <script type="text/javascript" src="{if ($localWebsite='true') then 'datatables.min.js' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.js'}"></script>
      
      <!-- ===== Dodatne resource datoteke ======================================= -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.responsive.min.js' else 'https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.buttons.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/dataTables.buttons.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.colVis.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/buttons.colVis.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.colReorder.min.js' else 'https://cdn.datatables.net/colreorder/1.3.3/js/dataTables.colReorder.min.js'}"></script>
      
      <script type="text/javascript" src="{if ($localWebsite='true') then 'jszip.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'pdfmake.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'vfs_fonts.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.html5.min.js' else 'https://cdn.datatables.net/buttons/1.4.2/js/buttons.html5.min.js'}"></script>
      <!-- določi, kje je naša dodatna DataTables js datoteka -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'range-filter-external-main.js' else 'range-filter-external-main.js'}"></script>
      
      <link href="{if ($localWebsite='true') then 'responsive.dataTables.min.css' else 'https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <link href="{if ($localWebsite='true') then 'buttons.dataTables.min.css' else 'https://cdn.datatables.net/buttons/1.4.1/css/buttons.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <!-- ===== Dodatne resource datoteke ======================================= -->
      
      <style>
         *, *::after, *::before {
         box-sizing: border-box;
         }
         .pagination .current {
         background: #8e130b;
         }
      </style>
      
      <script>
         var columnIDs = [3];
      </script>
      
      <ul class="accordion" data-accordion="" data-allow-all-closed="true">
         <li class="accordion-item" data-accordion-item="">
            <a href="#" class="accordion-title">Filtriraj po datumu</a>
            <div class="accordion-content rangeFilterWrapper" data-target="3" data-tab-content="">
               <div class="row">
                  <div class="small-3 columns">
                     <label for="middle-label" class="text-right middle">Filtriraj od datuma</label>
                  </div>
                  <div class="small-3 columns">
                     <input type="text" class="rangeMinYear" maxlength="4" placeholder="Leto"/>
                  </div>
                  <div class="small-3 columns">
                     <input type="text" class="rangeMinMonth" maxlength="2" placeholder="Mesec"/>
                  </div>
                  <div class="small-3 columns">
                     <input type="text" class="rangeMinDay" maxlength="2" placeholder="Dan"/>
                  </div>
               </div>
               <div class="row">
                  <div class="small-3 columns">
                     <label for="middle-label" class="text-right middle">do datuma</label>
                  </div>
                  <div class="small-3 columns">
                     <input type="text" class="rangeMaxYear" maxlength="4" placeholder="Leto"/>
                  </div>
                  <div class="small-3 columns">
                     <input type="text" class="rangeMaxMonth" maxlength="2" placeholder="Mesec"/>
                  </div>
                  <div class="small-3 columns">
                     <input type="text" class="rangeMaxDay" maxlength="2" placeholder="Dan"/>
                  </div>
                  <div class="small-12 columns" style="text-align: right;">
                     <a class="clearRangeFilter" href="#">Počisti filter</a>
                  </div>
               </div>
            </div>
         </li>
      </ul>
      
      <div>
         <table id="datatableMain" class="display responsive nowrap targetTable" width="100%" cellspacing="0">
            <thead>
               <tr>
                  <th>ID</th>
                  <th>Naslov</th>
                  <th>Avtor</th>
                  <th>Cenzura</th>
                  <th>Datum</th>
                  <th>Področje cenzure: morala</th>
                  <th>Področje cenzure: religija</th>
                  <th>Področje cenzure: politika</th>
                  <th>Področje cenzure: državne institucije</th>
               </tr>
            </thead>
            <tfoot>
               <tr>
                  <th></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
               </tr>
            </tfoot>
            <!--<tbody>-->
            <xsl:result-document href="docs_v3/data-main.json" method="text" encoding="UTF-8">
               <xsl:text>{
  "data": [&#xA;</xsl:text>
               <xsl:for-each select="//tei:body/tei:div">
                  <xsl:variable name="playID" select="@xml:id"/>
                  <xsl:variable name="playDate" select="tei:docDate/@when"/>
                  <xsl:variable name="playCensor" select="tei:label[1]"/>
                  <xsl:variable name="playMorality" select="tei:label[@type='morality']"/>
                  <xsl:variable name="playChurch" select="tei:label[@type='church']"/>
                  <xsl:variable name="playPolitics" select="tei:label[@type='politics']"/>
                  <xsl:variable name="playInst" select="tei:label[@type='state_institutions']"/>
                  <xsl:text>[&#xA;</xsl:text>
                  
                  <!-- ID -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:value-of select="concat('&lt;a href=\&quot;',$playID,'.html','\&quot; target=\&quot;_blank\&quot;&gt;',$playID,'&lt;/a&gt;')"/>
                  <xsl:text>&quot;,&#xA;</xsl:text>
                  
                  <!-- Naslov -->
                  <xsl:value-of select="concat('&quot;',normalize-space(tei:head),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Avtor -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:value-of>
                     <xsl:for-each select="tei:docAuthor">
                        <xsl:value-of select="normalize-space(.)"/>
                        <xsl:if test=" position() != last()">
                           <xsl:text> / </xsl:text>
                        </xsl:if>
                     </xsl:for-each>
                  </xsl:value-of>
                  <xsl:text>&quot;</xsl:text>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Cenzura -->
                  <xsl:value-of select="concat('&quot;',$playCensor,'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Leto -->
                  <xsl:value-of select="concat('&quot;',$playDate,'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Cenzura Moralnost -->
                  <xsl:value-of select="concat('&quot;',$playMorality,'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Cenzura religija-->
                  <xsl:value-of select="concat('&quot;',$playChurch,'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Cenzura politika-->
                  <xsl:value-of select="concat('&quot;',$playPolitics,'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Cenzura državne institucije-->
                  <xsl:value-of select="concat('&quot;',$playInst,'&quot;')"/>
                  <xsl:text>&#xA;</xsl:text>
                  
                  
                  <xsl:text>]</xsl:text>
                  <xsl:if test="position() != last()">
                     <xsl:text>,
                     </xsl:text>
                  </xsl:if>
               </xsl:for-each>
               <xsl:text>]
}</xsl:text>
            </xsl:result-document>
            
            <!--</tbody>-->
         </table>
         <br/>
         <br/>
         <br/>
      </div>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="datatables-genre">
      <link rel="stylesheet" type="text/css" href="{if ($localWebsite='true') then 'datatables.min.css' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.css'}" />
      <script type="text/javascript" src="{if ($localWebsite='true') then 'datatables.min.js' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.js'}"></script>
      
      <!-- ===== Dodatne resource datoteke ======================================= -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.responsive.min.js' else 'https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.buttons.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/dataTables.buttons.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.colVis.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/buttons.colVis.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.colReorder.min.js' else 'https://cdn.datatables.net/colreorder/1.3.3/js/dataTables.colReorder.min.js'}"></script>
      
      <script type="text/javascript" src="{if ($localWebsite='true') then 'jszip.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'pdfmake.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'vfs_fonts.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.html5.min.js' else 'https://cdn.datatables.net/buttons/1.4.2/js/buttons.html5.min.js'}"></script>
      <!-- določi, kje je naša dodatna DataTables js datoteka -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'range-filter-external-genre.js' else 'range-filter-external-genre.js'}"></script>
      
      <link href="{if ($localWebsite='true') then 'responsive.dataTables.min.css' else 'https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <link href="{if ($localWebsite='true') then 'buttons.dataTables.min.css' else 'https://cdn.datatables.net/buttons/1.4.1/css/buttons.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <!-- ===== Dodatne resource datoteke ======================================= -->
      
      <style>
         *, *::after, *::before {
         box-sizing: border-box;
         }
         .pagination .current {
         background: #8e130b;
         }
      </style>
      
      <script>
         var columnIDs = [1];
      </script>
      
      <div>
         <table id="datatableProvenience" class="display responsive nowrap targetTable" width="100%" cellspacing="0">
            <thead>
               <tr>
                  <th>ID</th>
                  <th>Zvrst</th>
                  <th>Naslov</th>
                  <th>Priložnost</th>
               </tr>
            </thead>
            <tfoot>
               <tr>
                  <th></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
               </tr>
            </tfoot>
            <!--<tbody>-->
            <xsl:result-document href="docs/data-genre.json" method="text" encoding="UTF-8">
               <xsl:text>{
  "data": [&#xA;</xsl:text>
               <xsl:for-each select="//tei:label[@type='genre']">
                  <xsl:variable name="playID" select="parent::tei:div/@xml:id"/>
                  <xsl:text>[&#xA;</xsl:text>
                  
                  <!-- ID -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:value-of select="concat('&lt;a href=\&quot;',$playID,'.html','\&quot; target=\&quot;_blank\&quot;&gt;',$playID,'&lt;/a&gt;')"/>
                  <xsl:text>&quot;,&#xA;</xsl:text>
                  
                  <!-- Stopnja ohranjenosti -->
                  <xsl:value-of select="concat('&quot;',normalize-space(.),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Naslov -->
                  <xsl:value-of select="concat('&quot;',substring-after(normalize-space(parent::tei:div/tei:head),': '),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Priložnost -->
                  <xsl:value-of select="concat('&quot;',substring-before(normalize-space(parent::tei:div/tei:head),': '),'&quot;')"/>
                  <xsl:text>&#xA;</xsl:text>
                  
                  <xsl:text>]</xsl:text>
                  <xsl:if test="position() != last()">
                     <xsl:text>,
                     </xsl:text>
                  </xsl:if>
               </xsl:for-each>
               <xsl:text>]
}</xsl:text>
            </xsl:result-document>
            
            <!--</tbody>-->
         </table>
         <br/>
         <br/>
         <br/>
      </div>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="datatables-type">
      <link rel="stylesheet" type="text/css" href="{if ($localWebsite='true') then 'datatables.min.css' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.css'}" />
      <script type="text/javascript" src="{if ($localWebsite='true') then 'datatables.min.js' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.js'}"></script>
      
      <!-- ===== Dodatne resource datoteke ======================================= -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.responsive.min.js' else 'https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.buttons.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/dataTables.buttons.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.colVis.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/buttons.colVis.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.colReorder.min.js' else 'https://cdn.datatables.net/colreorder/1.3.3/js/dataTables.colReorder.min.js'}"></script>
      
      <script type="text/javascript" src="{if ($localWebsite='true') then 'jszip.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'pdfmake.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'vfs_fonts.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.html5.min.js' else 'https://cdn.datatables.net/buttons/1.4.2/js/buttons.html5.min.js'}"></script>
      <!-- določi, kje je naša dodatna DataTables js datoteka -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'range-filter-external-type.js' else 'range-filter-external-type.js'}"></script>
      
      <link href="{if ($localWebsite='true') then 'responsive.dataTables.min.css' else 'https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <link href="{if ($localWebsite='true') then 'buttons.dataTables.min.css' else 'https://cdn.datatables.net/buttons/1.4.1/css/buttons.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <!-- ===== Dodatne resource datoteke ======================================= -->
      
      <style>
         *, *::after, *::before {
         box-sizing: border-box;
         }
         .pagination .current {
         background: #8e130b;
         }
      </style>
      
      <script>
         var columnIDs = [1];
      </script>
      
      <div>
         <table id="datatableType" class="display responsive nowrap targetTable" width="100%" cellspacing="0">
            <thead>
               <tr>
                  <th>ID</th>
                  <th>Vrsta</th>
                  <th>Naslov</th>
                  <th>Priložnost</th>
               </tr>
            </thead>
            <tfoot>
               <tr>
                  <th></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
               </tr>
            </tfoot>
            <!--<tbody>-->
            <xsl:result-document href="docs/data-type.json" method="text" encoding="UTF-8">
               <xsl:text>{
  "data": [&#xA;</xsl:text>
               <xsl:for-each select="//tei:label[@type='type']">
                  <xsl:variable name="playID" select="parent::tei:div/@xml:id"/>
                  <xsl:text>[&#xA;</xsl:text>
                  
                  <!-- ID -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:value-of select="concat('&lt;a href=\&quot;',$playID,'.html','\&quot; target=\&quot;_blank\&quot;&gt;',$playID,'&lt;/a&gt;')"/>
                  <xsl:text>&quot;,&#xA;</xsl:text>
                  
                  <!-- Stopnja ohranjenosti -->
                  <xsl:value-of select="concat('&quot;',normalize-space(.),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Naslov -->
                  <xsl:value-of select="concat('&quot;',substring-after(normalize-space(parent::tei:div/tei:head),': '),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Priložnost -->
                  <xsl:value-of select="concat('&quot;',substring-before(normalize-space(parent::tei:div/tei:head),': '),'&quot;')"/>
                  <xsl:text>&#xA;</xsl:text>
                  
                  <xsl:text>]</xsl:text>
                  <xsl:if test="position() != last()">
                     <xsl:text>,
                     </xsl:text>
                  </xsl:if>
               </xsl:for-each>
               <xsl:text>]
}</xsl:text>
            </xsl:result-document>
            
            <!--</tbody>-->
         </table>
         <br/>
         <br/>
         <br/>
      </div>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="datatables-provenience">
      <link rel="stylesheet" type="text/css" href="{if ($localWebsite='true') then 'datatables.min.css' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.css'}" />
      <script type="text/javascript" src="{if ($localWebsite='true') then 'datatables.min.js' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.js'}"></script>
      
      <!-- ===== Dodatne resource datoteke ======================================= -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.responsive.min.js' else 'https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.buttons.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/dataTables.buttons.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.colVis.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/buttons.colVis.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.colReorder.min.js' else 'https://cdn.datatables.net/colreorder/1.3.3/js/dataTables.colReorder.min.js'}"></script>
      
      <script type="text/javascript" src="{if ($localWebsite='true') then 'jszip.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'pdfmake.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'vfs_fonts.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.html5.min.js' else 'https://cdn.datatables.net/buttons/1.4.2/js/buttons.html5.min.js'}"></script>
      <!-- določi, kje je naša dodatna DataTables js datoteka -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'range-filter-external-provenience.js' else 'range-filter-external-provenience.js'}"></script>
      
      <link href="{if ($localWebsite='true') then 'responsive.dataTables.min.css' else 'https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <link href="{if ($localWebsite='true') then 'buttons.dataTables.min.css' else 'https://cdn.datatables.net/buttons/1.4.1/css/buttons.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <!-- ===== Dodatne resource datoteke ======================================= -->
      
      <style>
         *, *::after, *::before {
         box-sizing: border-box;
         }
         .pagination .current {
         background: #8e130b;
         }
      </style>
      
      <script>
         var columnIDs = [1];
      </script>
      
      <div>
         <table id="datatableProvenience" class="display responsive nowrap targetTable" width="100%" cellspacing="0">
            <thead>
               <tr>
                  <th>ID</th>
                  <th>Ohranjenost</th>
                  <th>Naslov</th>
                  <th>Priložnost</th>
               </tr>
            </thead>
            <tfoot>
               <tr>
                  <th></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
               </tr>
            </tfoot>
            <!--<tbody>-->
            <xsl:result-document href="docs/data-provenience.json" method="text" encoding="UTF-8">
               <xsl:text>{
  "data": [&#xA;</xsl:text>
               <xsl:for-each select="//tei:label[@type='provenience']">
                  <xsl:variable name="playID" select="parent::tei:div/@xml:id"/>
                  <xsl:text>[&#xA;</xsl:text>
                  
                  <!-- ID -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:value-of select="concat('&lt;a href=\&quot;',$playID,'.html','\&quot; target=\&quot;_blank\&quot;&gt;',$playID,'&lt;/a&gt;')"/>
                  <xsl:text>&quot;,&#xA;</xsl:text>
                  
                  <!-- Stopnja ohranjenosti -->
                  <xsl:value-of select="concat('&quot;',normalize-space(.),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Naslov -->
                  <xsl:value-of select="concat('&quot;',substring-after(normalize-space(parent::tei:div/tei:head),': '),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Priložnost -->
                  <xsl:value-of select="concat('&quot;',substring-before(normalize-space(parent::tei:div/tei:head),': '),'&quot;')"/>
                  <xsl:text>&#xA;</xsl:text>
                  
                  <xsl:text>]</xsl:text>
                  <xsl:if test="position() != last()">
                     <xsl:text>,
                     </xsl:text>
                  </xsl:if>
               </xsl:for-each>
               <xsl:text>]
}</xsl:text>
            </xsl:result-document>
            
            <!--</tbody>-->
         </table>
         <br/>
         <br/>
         <br/>
      </div>
   </xsl:template>
   
   <!-- genre2, Zvrstna opredelitev, row[5] -->
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="datatables-genre2">
      <link rel="stylesheet" type="text/css" href="{if ($localWebsite='true') then 'datatables.min.css' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.css'}" />
      <script type="text/javascript" src="{if ($localWebsite='true') then 'datatables.min.js' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.js'}"></script>
      
      <!-- ===== Dodatne resource datoteke ======================================= -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.responsive.min.js' else 'https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.buttons.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/dataTables.buttons.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.colVis.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/buttons.colVis.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.colReorder.min.js' else 'https://cdn.datatables.net/colreorder/1.3.3/js/dataTables.colReorder.min.js'}"></script>
      
      <script type="text/javascript" src="{if ($localWebsite='true') then 'jszip.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'pdfmake.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'vfs_fonts.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.html5.min.js' else 'https://cdn.datatables.net/buttons/1.4.2/js/buttons.html5.min.js'}"></script>
      <!-- določi, kje je naša dodatna DataTables js datoteka -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'range-filter-external-genre2.js' else 'range-filter-external-genre2.js'}"></script>
      
      <link href="{if ($localWebsite='true') then 'responsive.dataTables.min.css' else 'https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <link href="{if ($localWebsite='true') then 'buttons.dataTables.min.css' else 'https://cdn.datatables.net/buttons/1.4.1/css/buttons.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <!-- ===== Dodatne resource datoteke ======================================= -->
      
      <style>
         *, *::after, *::before {
         box-sizing: border-box;
         }
         .pagination .current {
         background: #8e130b;
         }
      </style>
      
      <script>
         var columnIDs = [1];
      </script>
      
      <div>
         <table id="datatableGenre2" class="display responsive nowrap targetTable" width="100%" cellspacing="0">
            <thead>
               <tr>
                  <th>ID</th>
                  <th>Zvrstna opredelitev</th>
                  <th>Naslov</th>
                  <th>Priložnost</th>
               </tr>
            </thead>
            <tfoot>
               <tr>
                  <th></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
               </tr>
            </tfoot>
            <!--<tbody>-->
            <xsl:result-document href="docs/data-genre2.json" method="text" encoding="UTF-8">
               <xsl:text>{
  "data": [&#xA;</xsl:text>
               <xsl:for-each select="//tei:table/tei:row/tei:cell[.='Zvrstna opredelitev'][string-length(following-sibling::tei:cell[1]) gt 0]">
                  <xsl:variable name="playID" select="ancestor::tei:div[1]/@xml:id"/>
                  <xsl:text>[&#xA;</xsl:text>
                  
                  <!-- ID -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:value-of select="concat('&lt;a href=\&quot;',$playID,'.html','\&quot; target=\&quot;_blank\&quot;&gt;',$playID,'&lt;/a&gt;')"/>
                  <xsl:text>&quot;,&#xA;</xsl:text>
                  
                  <!-- Zvrstna opredelitev -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:for-each select="following-sibling::tei:cell[1]">
                     <xsl:choose>
                        <xsl:when test="tei:p">
                           <xsl:value-of select="normalize-space(tei:p[1])"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:choose>
                              <xsl:when test="contains(.,':')">
                                 <xsl:value-of select="substring-before(normalize-space(.),':')"/>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:choose>
                                    <xsl:when test=" string-length(.) gt 50">
                                       <xsl:value-of select="concat(substring( normalize-space(.),1,50),' [...]')"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                       <xsl:value-of select="normalize-space(.)"/>
                                    </xsl:otherwise>
                                 </xsl:choose>
                              </xsl:otherwise>
                           </xsl:choose>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:for-each>
                  <xsl:text>&quot;</xsl:text>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Naslov -->
                  <xsl:value-of select="concat('&quot;',substring-after(normalize-space(ancestor::tei:div[1]/tei:head),': '),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Priložnost -->
                  <xsl:value-of select="concat('&quot;',substring-before(normalize-space(ancestor::tei:div[1]/tei:head),': '),'&quot;')"/>
                  <xsl:text>&#xA;</xsl:text>
                  
                  <xsl:text>]</xsl:text>
                  <xsl:if test="position() != last()">
                     <xsl:text>,
                     </xsl:text>
                  </xsl:if>
               </xsl:for-each>
               <xsl:text>]
}</xsl:text>
            </xsl:result-document>
            
            <!--</tbody>-->
         </table>
         <br/>
         <br/>
         <br/>
      </div>
   </xsl:template>
   
   <!-- year, Leto (ali šolsko leto) uprizoritve, row[6] -->
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="datatables-year">
      <link rel="stylesheet" type="text/css" href="{if ($localWebsite='true') then 'datatables.min.css' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.css'}" />
      <script type="text/javascript" src="{if ($localWebsite='true') then 'datatables.min.js' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.js'}"></script>
      
      <!-- ===== Dodatne resource datoteke ======================================= -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.responsive.min.js' else 'https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.buttons.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/dataTables.buttons.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.colVis.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/buttons.colVis.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.colReorder.min.js' else 'https://cdn.datatables.net/colreorder/1.3.3/js/dataTables.colReorder.min.js'}"></script>
      
      <script type="text/javascript" src="{if ($localWebsite='true') then 'jszip.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'pdfmake.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'vfs_fonts.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.html5.min.js' else 'https://cdn.datatables.net/buttons/1.4.2/js/buttons.html5.min.js'}"></script>
      <!-- določi, kje je naša dodatna DataTables js datoteka -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'range-filter-external-year.js' else 'range-filter-external-year.js'}"></script>
      
      <link href="{if ($localWebsite='true') then 'responsive.dataTables.min.css' else 'https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <link href="{if ($localWebsite='true') then 'buttons.dataTables.min.css' else 'https://cdn.datatables.net/buttons/1.4.1/css/buttons.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <!-- ===== Dodatne resource datoteke ======================================= -->
      
      <style>
         *, *::after, *::before {
         box-sizing: border-box;
         }
         .pagination .current {
         background: #8e130b;
         }
      </style>
      
      <script>
         var columnIDs = [1];
      </script>
      
      <div>
         <table id="datatableYear" class="display responsive nowrap targetTable" width="100%" cellspacing="0">
            <thead>
               <tr>
                  <th>ID</th>
                  <th>Leto (ali šolsko leto) uprizoritve</th>
                  <th>Naslov</th>
                  <th>Priložnost</th>
               </tr>
            </thead>
            <tfoot>
               <tr>
                  <th></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
               </tr>
            </tfoot>
            <!--<tbody>-->
            <xsl:result-document href="docs/data-year.json" method="text" encoding="UTF-8">
               <xsl:text>{
  "data": [&#xA;</xsl:text>
               <xsl:for-each select="//tei:table/tei:row/tei:cell[.='Leto (ali šolsko leto) uprizoritve'][string-length(following-sibling::tei:cell[1]) gt 0]">
                  <xsl:variable name="playID" select="ancestor::tei:div[1]/@xml:id"/>
                  <xsl:text>[&#xA;</xsl:text>
                  
                  <!-- ID -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:value-of select="concat('&lt;a href=\&quot;',$playID,'.html','\&quot; target=\&quot;_blank\&quot;&gt;',$playID,'&lt;/a&gt;')"/>
                  <xsl:text>&quot;,&#xA;</xsl:text>
                  
                  <!-- Leto (ali šolsko leto) uprizoritve -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:for-each select="following-sibling::tei:cell[1]">
                     <xsl:choose>
                        <xsl:when test="tei:p">
                           <xsl:value-of select="normalize-space(tei:p[1])"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:choose>
                              <xsl:when test="contains(.,':')">
                                 <xsl:value-of select="substring-before(normalize-space(.),':')"/>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:choose>
                                    <xsl:when test=" string-length(.) gt 50">
                                       <xsl:value-of select="concat(substring( normalize-space(.),1,50),' [...]')"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                       <xsl:value-of select="normalize-space(.)"/>
                                    </xsl:otherwise>
                                 </xsl:choose>
                              </xsl:otherwise>
                           </xsl:choose>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:for-each>
                  <xsl:text>&quot;</xsl:text>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Naslov -->
                  <xsl:value-of select="concat('&quot;',substring-after(normalize-space(ancestor::tei:div[1]/tei:head),': '),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Priložnost -->
                  <xsl:value-of select="concat('&quot;',substring-before(normalize-space(ancestor::tei:div[1]/tei:head),': '),'&quot;')"/>
                  <xsl:text>&#xA;</xsl:text>
                  
                  <xsl:text>]</xsl:text>
                  <xsl:if test="position() != last()">
                     <xsl:text>,
                     </xsl:text>
                  </xsl:if>
               </xsl:for-each>
               <xsl:text>]
}</xsl:text>
            </xsl:result-document>
            
            <!--</tbody>-->
         </table>
         <br/>
         <br/>
         <br/>
      </div>
   </xsl:template>
   
   <!-- opportunity, Priložnost uprizoritve, row[7] -->
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="datatables-opportunity">
      <link rel="stylesheet" type="text/css" href="{if ($localWebsite='true') then 'datatables.min.css' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.css'}" />
      <script type="text/javascript" src="{if ($localWebsite='true') then 'datatables.min.js' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.js'}"></script>
      
      <!-- ===== Dodatne resource datoteke ======================================= -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.responsive.min.js' else 'https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.buttons.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/dataTables.buttons.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.colVis.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/buttons.colVis.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.colReorder.min.js' else 'https://cdn.datatables.net/colreorder/1.3.3/js/dataTables.colReorder.min.js'}"></script>
      
      <script type="text/javascript" src="{if ($localWebsite='true') then 'jszip.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'pdfmake.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'vfs_fonts.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.html5.min.js' else 'https://cdn.datatables.net/buttons/1.4.2/js/buttons.html5.min.js'}"></script>
      <!-- določi, kje je naša dodatna DataTables js datoteka -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'range-filter-external-opportunity.js' else 'range-filter-external-opportunity.js'}"></script>
      
      <link href="{if ($localWebsite='true') then 'responsive.dataTables.min.css' else 'https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <link href="{if ($localWebsite='true') then 'buttons.dataTables.min.css' else 'https://cdn.datatables.net/buttons/1.4.1/css/buttons.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <!-- ===== Dodatne resource datoteke ======================================= -->
      
      <style>
         *, *::after, *::before {
         box-sizing: border-box;
         }
         .pagination .current {
         background: #8e130b;
         }
      </style>
      
      <script>
         var columnIDs = [1];
      </script>
      
      <div>
         <table id="datatableOpportunity" class="display responsive nowrap targetTable" width="100%" cellspacing="0">
            <thead>
               <tr>
                  <th>ID</th>
                  <th>Priložnost uprizoritve</th>
                  <th>Naslov</th>
                  <th>Priložnost</th>
               </tr>
            </thead>
            <tfoot>
               <tr>
                  <th></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
               </tr>
            </tfoot>
            <!--<tbody>-->
            <xsl:result-document href="docs/data-opportunity.json" method="text" encoding="UTF-8">
               <xsl:text>{
  "data": [&#xA;</xsl:text>
               <xsl:for-each select="//tei:table/tei:row/tei:cell[.='Priložnost uprizoritve'][string-length(following-sibling::tei:cell[1]) gt 0]">
                  <xsl:variable name="playID" select="ancestor::tei:div[1]/@xml:id"/>
                  <xsl:text>[&#xA;</xsl:text>
                  
                  <!-- ID -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:value-of select="concat('&lt;a href=\&quot;',$playID,'.html','\&quot; target=\&quot;_blank\&quot;&gt;',$playID,'&lt;/a&gt;')"/>
                  <xsl:text>&quot;,&#xA;</xsl:text>
                  
                  <!-- Priložnost uprizoritve -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:for-each select="following-sibling::tei:cell[1]">
                     <xsl:choose>
                        <xsl:when test="tei:p">
                           <xsl:value-of select="normalize-space(tei:p[1])"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:choose>
                              <xsl:when test="contains(.,':')">
                                 <xsl:value-of select="substring-before(normalize-space(.),':')"/>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:choose>
                                    <xsl:when test=" string-length(.) gt 50">
                                       <xsl:value-of select="concat(substring( normalize-space(.),1,50),' [...]')"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                       <xsl:value-of select="normalize-space(.)"/>
                                    </xsl:otherwise>
                                 </xsl:choose>
                              </xsl:otherwise>
                           </xsl:choose>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:for-each>
                  <xsl:text>&quot;</xsl:text>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Naslov -->
                  <xsl:value-of select="concat('&quot;',substring-after(normalize-space(ancestor::tei:div[1]/tei:head),': '),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Priložnost -->
                  <xsl:value-of select="concat('&quot;',substring-before(normalize-space(ancestor::tei:div[1]/tei:head),': '),'&quot;')"/>
                  <xsl:text>&#xA;</xsl:text>
                  
                  <xsl:text>]</xsl:text>
                  <xsl:if test="position() != last()">
                     <xsl:text>,
                     </xsl:text>
                  </xsl:if>
               </xsl:for-each>
               <xsl:text>]
}</xsl:text>
            </xsl:result-document>
            
            <!--</tbody>-->
         </table>
         <br/>
         <br/>
         <br/>
      </div>
   </xsl:template>
   
   <!-- stage, Kraj uprizoritve drame, row[12] -->
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="datatables-stage">
      <link rel="stylesheet" type="text/css" href="{if ($localWebsite='true') then 'datatables.min.css' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.css'}" />
      <script type="text/javascript" src="{if ($localWebsite='true') then 'datatables.min.js' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.js'}"></script>
      
      <!-- ===== Dodatne resource datoteke ======================================= -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.responsive.min.js' else 'https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.buttons.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/dataTables.buttons.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.colVis.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/buttons.colVis.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.colReorder.min.js' else 'https://cdn.datatables.net/colreorder/1.3.3/js/dataTables.colReorder.min.js'}"></script>
      
      <script type="text/javascript" src="{if ($localWebsite='true') then 'jszip.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'pdfmake.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'vfs_fonts.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.html5.min.js' else 'https://cdn.datatables.net/buttons/1.4.2/js/buttons.html5.min.js'}"></script>
      <!-- določi, kje je naša dodatna DataTables js datoteka -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'range-filter-external-stage.js' else 'range-filter-external-stage.js'}"></script>
      
      <link href="{if ($localWebsite='true') then 'responsive.dataTables.min.css' else 'https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <link href="{if ($localWebsite='true') then 'buttons.dataTables.min.css' else 'https://cdn.datatables.net/buttons/1.4.1/css/buttons.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <!-- ===== Dodatne resource datoteke ======================================= -->
      
      <style>
         *, *::after, *::before {
         box-sizing: border-box;
         }
         .pagination .current {
         background: #8e130b;
         }
      </style>
      
      <script>
         var columnIDs = [1];
      </script>
      
      <div>
         <table id="datatableStage" class="display responsive nowrap targetTable" width="100%" cellspacing="0">
            <thead>
               <tr>
                  <th>ID</th>
                  <th>Kraj uprizoritve drame</th>
                  <th>Naslov</th>
                  <th>Priložnost</th>
               </tr>
            </thead>
            <tfoot>
               <tr>
                  <th></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
               </tr>
            </tfoot>
            <!--<tbody>-->
            <xsl:result-document href="docs/data-stage.json" method="text" encoding="UTF-8">
               <xsl:text>{
  "data": [&#xA;</xsl:text>
               <xsl:for-each select="//tei:table/tei:row/tei:cell[.='Kraj uprizoritve drame'][string-length(following-sibling::tei:cell[1]) gt 0]">
                  <xsl:variable name="playID" select="ancestor::tei:div[1]/@xml:id"/>
                  <xsl:text>[&#xA;</xsl:text>
                  
                  <!-- ID -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:value-of select="concat('&lt;a href=\&quot;',$playID,'.html','\&quot; target=\&quot;_blank\&quot;&gt;',$playID,'&lt;/a&gt;')"/>
                  <xsl:text>&quot;,&#xA;</xsl:text>
                  
                  <!-- Kraj uprizoritve drame -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:for-each select="following-sibling::tei:cell[1]">
                     <xsl:choose>
                        <xsl:when test="tei:p">
                           <xsl:value-of select="normalize-space(tei:p[1])"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:choose>
                              <xsl:when test="contains(.,':')">
                                 <xsl:value-of select="substring-before(normalize-space(.),':')"/>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:choose>
                                    <xsl:when test=" string-length(.) gt 50">
                                       <xsl:value-of select="concat(substring( normalize-space(.),1,50),' [...]')"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                       <xsl:value-of select="normalize-space(.)"/>
                                    </xsl:otherwise>
                                 </xsl:choose>
                              </xsl:otherwise>
                           </xsl:choose>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:for-each>
                  <xsl:text>&quot;</xsl:text>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Naslov -->
                  <xsl:value-of select="concat('&quot;',substring-after(normalize-space(ancestor::tei:div[1]/tei:head),': '),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Priložnost -->
                  <xsl:value-of select="concat('&quot;',substring-before(normalize-space(ancestor::tei:div[1]/tei:head),': '),'&quot;')"/>
                  <xsl:text>&#xA;</xsl:text>
                  
                  <xsl:text>]</xsl:text>
                  <xsl:if test="position() != last()">
                     <xsl:text>,
                     </xsl:text>
                  </xsl:if>
               </xsl:for-each>
               <xsl:text>]
}</xsl:text>
            </xsl:result-document>
            
            <!--</tbody>-->
         </table>
         <br/>
         <br/>
         <br/>
      </div>
   </xsl:template>
   
   <!-- actors, Kdo jo je igral?, row[13] -->
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="datatables-actors">
      <link rel="stylesheet" type="text/css" href="{if ($localWebsite='true') then 'datatables.min.css' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.css'}" />
      <script type="text/javascript" src="{if ($localWebsite='true') then 'datatables.min.js' else 'https://cdn.datatables.net/v/zf/dt-1.10.13/cr-1.3.2/datatables.min.js'}"></script>
      
      <!-- ===== Dodatne resource datoteke ======================================= -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.responsive.min.js' else 'https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.buttons.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/dataTables.buttons.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.colVis.min.js' else 'https://cdn.datatables.net/buttons/1.4.1/js/buttons.colVis.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'dataTables.colReorder.min.js' else 'https://cdn.datatables.net/colreorder/1.3.3/js/dataTables.colReorder.min.js'}"></script>
      
      <script type="text/javascript" src="{if ($localWebsite='true') then 'jszip.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'pdfmake.min.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'vfs_fonts.js' else 'https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js'}"></script>
      <script type="text/javascript" src="{if ($localWebsite='true') then 'buttons.html5.min.js' else 'https://cdn.datatables.net/buttons/1.4.2/js/buttons.html5.min.js'}"></script>
      <!-- določi, kje je naša dodatna DataTables js datoteka -->
      <script type="text/javascript" src="{if ($localWebsite='true') then 'range-filter-external-actors.js' else 'range-filter-external-actors.js'}"></script>
      
      <link href="{if ($localWebsite='true') then 'responsive.dataTables.min.css' else 'https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <link href="{if ($localWebsite='true') then 'buttons.dataTables.min.css' else 'https://cdn.datatables.net/buttons/1.4.1/css/buttons.dataTables.min.css'}" rel="stylesheet" type="text/css" />
      <!-- ===== Dodatne resource datoteke ======================================= -->
      
      <style>
         *, *::after, *::before {
         box-sizing: border-box;
         }
         .pagination .current {
         background: #8e130b;
         }
      </style>
      
      <script>
         var columnIDs = [1];
      </script>
      
      <div>
         <table id="datatableActors" class="display responsive nowrap targetTable" width="100%" cellspacing="0">
            <thead>
               <tr>
                  <th>ID</th>
                  <th>Kdo jo je igral?</th>
                  <th>Naslov</th>
                  <th>Priložnost</th>
               </tr>
            </thead>
            <tfoot>
               <tr>
                  <th></th>
                  <th><select class="filterSelect"><option value="">Prikaži vse</option></select></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
                  <th><input class="filterInputText" placeholder="Iskanje" type="text"/></th>
               </tr>
            </tfoot>
            <!--<tbody>-->
            <xsl:result-document href="docs/data-actors.json" method="text" encoding="UTF-8">
               <xsl:text>{
  "data": [&#xA;</xsl:text>
               <xsl:for-each select="//tei:table/tei:row/tei:cell[.='Kdo jo je igral?'][string-length(following-sibling::tei:cell[1]) gt 0]">
                  <xsl:variable name="playID" select="ancestor::tei:div[1]/@xml:id"/>
                  <xsl:text>[&#xA;</xsl:text>
                  
                  <!-- ID -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:value-of select="concat('&lt;a href=\&quot;',$playID,'.html','\&quot; target=\&quot;_blank\&quot;&gt;',$playID,'&lt;/a&gt;')"/>
                  <xsl:text>&quot;,&#xA;</xsl:text>
                  
                  <!-- Kdo jo je igral? -->
                  <xsl:text>&quot;</xsl:text>
                  <xsl:for-each select="following-sibling::tei:cell[1]">
                     <xsl:choose>
                        <xsl:when test="tei:p">
                           <xsl:value-of select="normalize-space(tei:p[1])"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:choose>
                              <xsl:when test="contains(.,':')">
                                 <xsl:value-of select="substring-before(normalize-space(.),':')"/>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:choose>
                                    <xsl:when test=" string-length(.) gt 50">
                                       <xsl:value-of select="concat(substring( normalize-space(.),1,50),' [...]')"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                       <xsl:value-of select="normalize-space(.)"/>
                                    </xsl:otherwise>
                                 </xsl:choose>
                              </xsl:otherwise>
                           </xsl:choose>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:for-each>
                  <xsl:text>&quot;</xsl:text>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Naslov -->
                  <xsl:value-of select="concat('&quot;',substring-after(normalize-space(ancestor::tei:div[1]/tei:head),': '),'&quot;')"/>
                  <xsl:text>,&#xA;</xsl:text>
                  
                  <!-- Priložnost -->
                  <xsl:value-of select="concat('&quot;',substring-before(normalize-space(ancestor::tei:div[1]/tei:head),': '),'&quot;')"/>
                  <xsl:text>&#xA;</xsl:text>
                  
                  <xsl:text>]</xsl:text>
                  <xsl:if test="position() != last()">
                     <xsl:text>,
                     </xsl:text>
                  </xsl:if>
               </xsl:for-each>
               <xsl:text>]
}</xsl:text>
            </xsl:result-document>
            
            <!--</tbody>-->
         </table>
         <br/>
         <br/>
         <br/>
      </div>
   </xsl:template>
   
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc> NASLOVNA STRAN </xsldoc:desc>
   </xsldoc:doc>
   <xsl:template match="tei:titlePage">
      <!-- naslov -->
      <xsl:for-each select="tei:docTitle/tei:titlePart[1]">
         <h1 class="text-center"><xsl:value-of select="."/></h1>
         <xsl:for-each select="following-sibling::tei:titlePart">
            <h1 class="subheader podnaslov"><xsl:value-of select="."/></h1>
         </xsl:for-each>
      </xsl:for-each>
      <!-- avtor -->
      <p  class="naslovnicaAvtor">
         <xsl:for-each select="tei:docAuthor">
            <xsl:choose>
               <xsl:when test="tei:forename or tei:surname">
                  <xsl:for-each select="tei:forename">
                     <xsl:value-of select="."/>
                     <xsl:if test="position() ne last()">
                        <xsl:text> </xsl:text>
                     </xsl:if>
                  </xsl:for-each>
                  <xsl:if test="tei:surname">
                     <xsl:text> </xsl:text>
                  </xsl:if>
                  <xsl:for-each select="tei:surname">
                     <xsl:value-of select="."/>
                     <xsl:if test="position() ne last()">
                        <xsl:text> </xsl:text>
                     </xsl:if>
                  </xsl:for-each>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:apply-templates/>
               </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="position() ne last()">
               <br/>
            </xsl:if>
         </xsl:for-each>
      </p>
      <br/>
      <xsl:if test="tei:figure">
         <div class="text-center">
            <p>
               <img src="{tei:figure/tei:graphic/@url}" alt="naslovna slika"/>
            </p>
         </div>
      </xsl:if>
      <xsl:if test="tei:graphic">
         <div class="text-center">
            <p>
               <img src="{tei:graphic/@url}" alt="naslovna slika"/>
            </p>
         </div>
      </xsl:if>
      <br/>
      <p class="text-center">
         <!-- založnik -->
         <xsl:for-each select="tei:docImprint/tei:publisher">
            <xsl:value-of select="."/>
            <br/>
         </xsl:for-each>
         <!-- kraj izdaje -->
         <xsl:for-each select="tei:docImprint/tei:pubPlace">
            <xsl:value-of select="."/>
            <br/>
         </xsl:for-each>
         <!-- leto izdaje -->
         <xsl:for-each select="tei:docImprint/tei:docDate">
            <xsl:value-of select="."/>
            <br/>
         </xsl:for-each>
      </p>
      <!-- dodani povzetki -->
      <xsl:for-each select="ancestor::tei:TEI/tei:teiHeader/tei:profileDesc/tei:abstract">
         <xsl:choose>
            <xsl:when test="@xml:lang = 'sl'">
               <p style="text-align:justify;">
                  <!--<xsl:text>POVZETEK: </xsl:text>-->
                  <!--<xsl:copy-of select="."/>-->
                  Digitalni repozitorij je nastal v okviru raziskovalnega projekta ARRS Slovenski literati in cesarska cenzura v dolgem 19. stoletju (J6-2583) (2020-2023) <a href="https://imprimatur.zrc-sazu.si/">https://imprimatur.zrc-sazu.si/</a>. V njem so zbrani dokumenti o cenzuri gledaliških besedil, ki jih je Dramatično društvo nameravalo uprizoriti in je za to moralo zaprositi Deželno predsedstvo Kranjske. Repozitorij vsebuje popis teh cenzurnih dokumentov, ki so se ohranili v fondu Deželnega predsedstva za Kranjsko v Arhivu Republike Slovenije, faksimile dokumentov, kjer je cenzor zahteval določene posege v besedilo (predvsem izpuste besed in replik) ter še nekaj dokumentov, ki so povezani s cenzuriranjem gledaliških besedil.
               </p>
               <br/>
               <br/>
            </xsl:when>
            <xsl:when test="@xml:lang = 'en'">
               <p>
                  <xsl:text>ABSTRACT: </xsl:text>
                  <xsl:copy-of select="."/>
               </p>
               <br/>
               <br/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:message>Unknown abstract language <xsl:value-of select="@xml:lang"
               /></xsl:message>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:for-each>
      <br/>
      
   </xsl:template>
      
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>dodal pdf</desc>
   </doc>
   <xsl:template match="tei:figure[@type = 'appPDF']">
      <br></br>
      <embed src="{tei:graphic/@url}" type="application/pdf" height="1400" width="100%"/>
   </xsl:template>
   
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc> Dodaten link v kolofonu takoj za naslovom </xsldoc:desc>
   </xsldoc:doc>
   <xsl:template match="tei:titleStmt" mode="kolofon">
      <!-- avtor -->
      <p>
         <xsl:for-each select="tei:author">
            <span itemprop="author">
               <xsl:choose>
                  <xsl:when test="tei:forename or tei:surname">
                     <xsl:for-each select="tei:forename">
                        <xsl:value-of select="."/>
                        <xsl:if test="position() ne last()">
                           <xsl:text> </xsl:text>
                        </xsl:if>
                     </xsl:for-each>
                     <xsl:if test="tei:surname">
                        <xsl:text> </xsl:text>
                     </xsl:if>
                     <xsl:for-each select="tei:surname">
                        <xsl:value-of select="."/>
                        <xsl:if test="position() ne last()">
                           <xsl:text> </xsl:text>
                        </xsl:if>
                     </xsl:for-each>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="."/>
                  </xsl:otherwise>
               </xsl:choose>
            </span>
            <xsl:if test="position() != last()">
               <br/>
            </xsl:if>
         </xsl:for-each>
      </p>
      <!-- Naslov mora vedno biti, zato ne preverjam, če obstaja. -->
      <p itemprop="name">
         <xsl:for-each select="tei:title[1]">
            <b><xsl:value-of select="."/></b>
            <xsl:if test="following-sibling::tei:title">
               <xsl:text> : </xsl:text>
            </xsl:if>
            <xsl:for-each select="following-sibling::tei:title">
               <xsl:value-of select="."/>
               <xsl:if test="position() != last()">
                  <xsl:text>, </xsl:text>
               </xsl:if>
            </xsl:for-each>
         </xsl:for-each>
      </p>
      <br/>
      <br/>
      <xsl:apply-templates select="tei:respStmt" mode="kolofon"/>
      <br/>
      <xsl:if test="tei:funder">
         <xsl:for-each select="tei:funder">
            <p itemprop="funder">
               <xsl:value-of select="."/>
            </p>
            <p>
               <a href="https://imprimatur.zrc-sazu.si/">https://imprimatur.zrc-sazu.si/</a>
            </p>
         </xsl:for-each>
      </xsl:if>
      <br/>
   </xsl:template>
   
</xsl:stylesheet>
