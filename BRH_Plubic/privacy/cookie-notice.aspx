﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="cookie-notice.aspx.cs" Inherits="BRH_Plubic.privacy.cookie_notice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentDesktop" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .fontTopic {
        font-size: x-large;
        font-weight: bold;
    }
    .boxDatail {
        font-size: large;
        font-weight: bold;
        margin-left: 100px; 
        margin-right: 0px;
    }
    li::marker {
        color: black;
    }
</style>
    <div class="row col-12 mx-auto fontGoogle">
        <div class="col-12 mx-auto" style="font-size: xx-large; font-weight: bold;">
            ประกาศการใช้งานคุกกี้
        </div>
        <div class="col-11 my-3 boxDatail">
            เว็บไซต์นี้ใช้คุกกี้และเครื่องมืออื่น เช่น Google Analytics เพื่อช่วยแยกแยะรูปแบบการใช้งานเว็บไซต์ของท่านจากผู้ใช้งานอื่น ๆ ซึ่งจะช่วยให้ท่านได้รับประสบการณ์ที่ดีจากการใช้งานเว็บไซต์ และช่วยให้เราสามารถพัฒนาคุณภาพของเว็บไซต์ให้ดียิ่งขึ้น กรณีที่ท่านใช้งานเว็บไซต์นี้ต่อไป ถือว่าท่านได้ยินยอมให้เราติดตั้งคุกกี้ไว้ในเครื่องคอมพิวเตอร์ของท่าน
        </div>
        <div class="col-12 my-3 fontTopic">
            คุกกี้คืออะไร?
        </div>
        <div class="col-11 boxDatail">
            คุกกี้ คือ ข้อความขนาดเล็กที่ประกอบด้วยส่วนของข้อมูลที่มาจากการดาวน์โหลดที่อาจถูกเก็บบันทึกไว้ในเว็บเบราว์เซอร์ที่ท่านใช้งานหรืออุปกรณ์อื่น ๆ ที่ต่อเชื่อมอินเทอร์เน็ต (อาทิ เครื่องคอมพิวเตอร์ สมาร์ทโฟน หรือแท็บเล็ตของท่าน) โดยที่เครื่องเซิร์ฟเวอร์สามารถเรียกดูได้ในภายหลัง คล้ายกับหน่วยความจำของหน้าเว็บ
        </div>
        <div class="col-11 my-3 boxDatail">
            การทำงานของคุกกี้ ช่วยให้เรารวบรวมและจัดเก็บข้อมูลการเยี่ยมชมเว็บไซต์ของท่านดังต่อไปนี้โดยอัตโนมัติ
            <ul>
                <li><i class="ti-control-record"></i> อินเทอร์เน็ตโดเมนและ IP Address จากจุดที่ท่านเข้าสู่เว็บไซต์</li>
                <li><i class="ti-control-record"></i> ประเภทของเบราว์เซอร์ซอฟต์แวร์ ตลอดจนโครงสร้างและระบบการปฏิบัติงานที่ใช้ในการเข้าสู่เว็บไซต์</li>
                <li><i class="ti-control-record"></i> วันที่และเวลาที่ท่านเข้าสู่เว็บไซต์</li>
                <li><i class="ti-control-record"></i> ที่อยู่ของเว็บไซต์อื่นที่เชื่อมโยงท่านเข้าสู่เว็บไซต์ของเรา</li>
                <li><i class="ti-control-record"></i> หน้าเว็บที่ท่านเข้าเยี่ยมชม และนำท่านออกจากเว็บไซต์ของเรา รวมถึงเนื้อหาบนหน้าเว็บที่ท่านเยี่ยมชมและระยะเวลาที่ท่านใช้ในการเยี่ยมชม</li>
            </ul>
        </div>
        <div class="col-12 my-3 fontTopic">
            การใช้งานคุกกี้
        </div>
        <div class="col-11 my-3 boxDatail">
            ประเภทของคุกกี้ที่เราใช้และในการใช้คุกกี้ดังกล่าว ประกอบด้วย แต่ไม่จำกัดเพียง รายการต่อไปนี้
            <ul>
                <li><i class="ti-control-record"></i><u>คุกกี้ประเภทที่มีความจำเป็นอย่างยิ่ง (Strictly Necessary Cookies):</u>
                    คุกกี้ประเภทนี้มีความสำคัญต่อการทำงานของเว็บไซต์ ซึ่งรวมถึงคุกกี้ที่ทำให้ท่านสามารถเข้าถึงข้อมูลและใช้งานในเว็บไซต์ของเราได้อย่างปลอดภัย
                </li>
                <li><i class="ti-control-record"></i><u>คุกกี้เพื่อการวิเคราะห์/วัดผลการทำงานของเว็บไซต์ (Analytical/Performance Cookies):</u>
                    คุกกี้ประเภทนี้จะช่วยให้เราสามารถจดจำและนับจำนวนผู้เข้าเยี่ยมชมเว็บไซต์ตลอดจนช่วยให้เราทราบถึงพฤติกรรมในการเยี่ยมชมเว็บไซต์ เพื่อปรับปรุงการทำงานของเว็บไซต์ให้มีคุณภาพดีขึ้นและมีความเหมาะสมมากขึ้น อีกทั้งเพื่อรวบรวมข้อมูลทางสถิติเกี่ยวกับวิธีการเข้าและพฤติกรรมการเยี่ยมชมเว็บไซต์ ซึ่งจะช่วยปรับปรุงการทำงานของเว็บไซต์โดยให้ผู้ใช้งานสามารถค้นหาสิ่งที่ต้องการได้อย่างง่ายดาย และช่วยให้เราเข้าใจถึงความสนใจของผู้ใช้ และวัดความมีประสิทธิผลของโฆษณาของเรา
                </li>
                <li><i class="ti-control-record"></i><u>คุกกี้เพื่อการทำงานของเว็บไซต์ (Functionality Cookies):</u>
                    คุกกี้ประเภทนี้ใช้ในการจดจำตัวท่านเมื่อท่านกลับมาใช้งานเว็บไซต์อีกครั้ง ซึ่งจะช่วยให้เราสามารถปรับแต่งเนื้อหาสำหรับท่าน ปรับให้เว็บไซต์ของเราตอบสนองความต้องการใช้งานของท่าน รวมถึงจดจำการตั้งค่าของท่าน อาทิ ภาษา หรือภูมิภาค หรือขนาดของตัวอักษรที่ท่านเลือกใช้ในการใช้งานในเว็บไซต์
                </li>
                <li><i class="ti-control-record"></i><u>คุกกี้เพื่อปรับเนื้อหาเข้ากับกลุ่มเป้าหมาย (Targeting Cookies):</u>
                    คุกกี้ประเภทนี้จะบันทึกการเข้าชมเว็บไซต์ของท่าน หน้าเว็บที่ท่านได้เยี่ยมชม และลิงก์ที่ท่านเยี่ยมชม เราจะใช้ข้อมูลนี้เพื่อปรับให้เว็บไซต์และเนื้อหาใด ๆ ที่ปรากฏอยู่บนหน้าเว็บตรงกับความสนใจของคุณมากขึ้น นอกจากนี้ เรายังอาจแชร์ข้อมูลนี้กับบุคคลที่สามเพื่อวัตถุประสงค์ดังกล่าว
                </li>
                <li><i class="ti-control-record"></i><u>คุกกี้เพื่อการโฆษณา (Advertising Cookies):</u>
                    คุกกี้ประเภทนี้จะจดจำการตั้งค่าของท่านในการเข้าใช้งานหน้าเว็บไซต์ และนำไปใช้เป็นข้อมูลประกอบการปรับเปลี่ยนหน้าเว็บไซต์เพื่อนำเสนอโฆษณาที่เหมาะสมกับท่านมากที่สุดเท่าที่จะเป็นไปได้ ตัวอย่างเช่น การเลือกแสดงโฆษณาสินค้าที่ท่านสนใจ การป้องกันหรือการจำกัดจำนวนครั้งที่ท่านจะเห็นหน้าเว็บไซต์ของโฆษณาซ้ำ ๆ เพื่อช่วยวัดความมีประสิทธิผลของโฆษณา
                </li>
            </ul>
            <br />
            โปรดทราบว่าคุกกี้บางประเภทในเว็บไซต์นี้จัดการโดยบุคคลที่สาม เช่น เครือข่ายการโฆษณา ลักษณะการทำงานต่าง ๆ อาทิ วิดีโอ แผนที่ และโซเชียลมีเดีย และผู้ให้บริการเว็บไซต์ภายนอกอื่น ๆ เช่น บริการวิเคราะห์การเข้าเยี่ยมชมเว็บไซต์ เป็นต้น คุกกี้เหล่านี้มักจะเป็นคุกกี้เพื่อการวิเคราะห์/วัดผลการทำงาน หรือคุกกี้เพื่อปรับเนื้อหาเข้ากับกลุ่มเป้าหมาย ท่านควรต้องศึกษานโยบายการใช้คุกกี้และนโยบายส่วนบุคคลในเว็บไซต์ของบุคคลที่สาม เพื่อให้เข้าใจถึงวิธีการที่บุคคลที่สามอาจนำข้อมูลของท่านไปใช้
        </div>
        <div class="col-12 my-3 fontTopic">
            การตั้งค่าคุกกี้
        </div>
        <div class="col-11 my-3 boxDatail">
            ท่านสามารถบล็อกการทำงานของคุกกี้ได้โดยการกำหนดค่าในเบราว์เซอร์ของท่าน ซึ่งท่านอาจปฏิเสธการติดตั้งค่าคุกกี้ทั้งหมดหรือบางประเภทก็ได้ แต่พึงตระหนักว่าหากท่านตั้งค่าเบราว์เซอร์ของท่านด้วยการบล็อกคุกกี้ทั้งหมด (รวมถึงคุกกี้ที่จำเป็นต่อการใช้งาน) ท่านอาจจะไม่สามารถเข้าสู่เว็บไซต์ทั้งหมดหรือบางส่วนของเราได้
        </div>
        <div class="col-11 my-3 boxDatail">
            เมื่อใดก็ตามที่ท่านต้องการยกเลิกความยินยอมการใช้งานคุกกี้ ท่านจะต้องตั้งค่าเบราว์เซอร์ของท่านเพื่อให้ลบคุกกี้ออกจากแต่ละเบราว์เซอร์ที่ท่านใช้งาน
        </div>
    </div>

</asp:Content>