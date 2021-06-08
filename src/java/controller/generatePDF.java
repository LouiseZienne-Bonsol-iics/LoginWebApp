/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import listener.*;

public class generatePDF extends HttpServlet{
    Connection conn;
    String exceptStr;
    String genUser;
    String genRole;
    
    public void init(ServletConfig config) throws ServletException {
        super.init(config);     
        exceptStr = getServletContext().getInitParameter("exceptStr");
    }

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            genUser = (String)request.getSession().getAttribute("userSession");
            genRole = (String)request.getSession().getAttribute("roleSession");
            
            response.setHeader("Content-Disposition","inline;filename=" + genUser + "_" + genRole + ".pdf");
            response.setContentType("application/pdf");
            response.setContentType("application/OCTET-STREAM");
            
            MyDatabase mydata = (MyDatabase) getServletContext().getAttribute("db");  
            conn = mydata.getCon();
            java.util.Date date=new java.util.Date();
            
            class HeaderFooter extends PdfPageEventHelper {
               @Override
               public void onStartPage(PdfWriter writer, Document document) {
                   ColumnText.showTextAligned(writer.getDirectContent(), Element.ALIGN_CENTER, new Phrase(getServletContext().getInitParameter("header")), 307, 710, 0);
                   ColumnText.showTextAligned(writer.getDirectContent(), Element.ALIGN_CENTER, new Phrase("Table of Other Registered Users"), 307, 680, 0);
               }

               @Override
               public void onEndPage(PdfWriter writer, Document document) {
                   ColumnText.showTextAligned(writer.getDirectContent(), Element.ALIGN_LEFT, new Phrase("Report generated  by: " + genUser), 90, 90, 0);
                   ColumnText.showTextAligned(writer.getDirectContent(), Element.ALIGN_LEFT, new Phrase("Date and Time: " + date), 90, 77, 0);
                   ColumnText.showTextAligned(writer.getDirectContent(), Element.ALIGN_CENTER, new Phrase(getServletContext().getInitParameter("footer")), 307, 30, 0);
                   ColumnText.showTextAligned(writer.getDirectContent(), Element.ALIGN_LEFT, new Phrase("Page " + 
                           document.getPageNumber()), 90, 65, 0);
               }

           }
            
            if(request.getParameter("genPDF") != null){
                
                if(conn!=null){
                    try{
                        Document doc = new Document();
                        Rectangle rect = new Rectangle(PageSize.LETTER);
                        doc.setPageSize(rect);
                        
                        doc.setMargins(50, 45, 150, 150);
                        doc.setMarginMirroring(false);
                        
                        PdfWriter writer = PdfWriter.getInstance(doc, response.getOutputStream());
                        HeaderFooter event = new HeaderFooter();
                        writer.setPageEvent(event);
                        
                        doc.open();

                        //Paragraph space = new Paragraph(" ");
                        
                        PreparedStatement ps = conn.prepareStatement(exceptStr);
                        ps.setString(1, genUser);
                        ResultSet rs = ps.executeQuery();
                        
                        PdfPTable table = new PdfPTable(2);
                        table.setSpacingBefore(100f);   
                        table.setSpacingAfter(10f);  
                        PdfPCell c1 = new PdfPCell(new Phrase("Username"));
                        c1.setBackgroundColor(BaseColor.YELLOW);
                        c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
                        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                        table.addCell(c1);
                        
                        c1 = new PdfPCell(new Phrase("Role"));
                        c1.setBackgroundColor(BaseColor.YELLOW);
                        c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
                        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                        table.addCell(c1);
                        table.setHeaderRows(1);

                        while(rs.next()){
                            PdfPCell cell = new PdfPCell(new Phrase(rs.getString("USERNAME")));
                            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                            table.addCell(cell);
                            cell = new PdfPCell(new Phrase(rs.getString("ROLES")));
                            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                            table.addCell(cell);
                        }
                        
                        //doc.add(space);
                        doc.add(table);
                        doc.close();
                    }
                    catch(Exception e){
                        e.printStackTrace();
                    }
                }
            }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
