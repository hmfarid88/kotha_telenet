<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="java.io.File"%>
<%@page import="DB.Ssymphonyy"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html class="no-js" lang="">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Mobile Store</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="icon" type="image/png" href="img/favicon.ico">
    </head>
    <body>
        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
        <div id="main" class="container-fluid">
            <nav style="margin: 0 auto" class="navbar navbar-inverse">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar"> 
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                        </div>

                        <div class="collapse navbar-collapse" id="myNavbar">
                            <ul class="nav navbar-nav">
                           
                                <li style="margin-left: 20px"><a href="home.jsp"><span class="fa fa-home"></span> Home</a></li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li style=" margin-right: 50px; margin-top: 15px"><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li> 
                                <li> <a name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>

                        </div>

                    </nav>
            
            <br><div id="div_print">
                <center>
                    <h3>Delete Stock (Accessories) </h3>
                    <h4><script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                    <hr>
                    <table  border="2" id="mobiletable" class="table-striped table-responsive" width="95%" >
                        <thead>
                            <tr style="background-color: black; color: #ffffff">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Product Name</th>
                                <th style="text-align: center">Product ID</th>
                                <th style="text-align: center">Vendor</th>
                                <th style="text-align: center">Qty</th>
                                <th style="text-align: center">Cost Price</th>
                                <th style="text-align: center">Sale Price</th>
                                <th style="text-align: center">Note</th>
                                <th style="text-align: center">Stock Date</th>
                                <th style="text-align: center">Delete Date</th>
                            </tr>
                        </thead> 
                        <%
                               Connection con = null;
                               PreparedStatement ps = null;
                               ResultSet rs=null; 
                            try {
                               con = Ssymphonyy.getConnection();
                               String query = "select PRODUCT_NAME, MODEL, PRODUCT_ID, COST_PRICE, SELL_PRICE, VENDOR, NOTE, STOCK_DATE, DATE from acc_stock_del";
                               ps = con.prepareStatement(query);
                                rs = ps.executeQuery();
                                while (rs.next()) {
                        %>
                        <tbody id="myTable">
                            <tr>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= rs.getString("PRODUCT_NAME")%> <%= rs.getString("MODEL")%></td>
                                <td style="text-align: center"><%= rs.getString("PRODUCT_ID")%></td>
                                <td style="text-align: center"><%= rs.getString("VENDOR")%></td>
                                <th style="text-align: center">1</th>
                                <th style="text-align: center"><%= rs.getFloat("COST_PRICE")%></th>
                                <th style="text-align: center"><%= rs.getFloat("SELL_PRICE")%></th>
                                <td style="text-align: center"><%= rs.getString("NOTE")%></td>
                                <td style="text-align: center"><%= rs.getString("STOCK_DATE")%></td>
                                <td style="text-align: center"><%= rs.getString("DATE")%></td>
                            </tr>

                        <%
                                }
                            } catch (Exception ex) {
                            }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                        %>
                        </tbody>
                        
                       <tfoot>
                            <tr style="background-color: #cccccc">
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <th style="text-align: center">TOTAL</th>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"></td>
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                            </tr>
                        </tfoot>
                   </table>
                </center>
            </div><br>
           
        </div>
     <%@include file = "footerpage.jsp" %> 
        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        
        <script language="javascript">
            function printdiv(printpage)
            {
                var headstr = "<html><head><title></title></head><body>";
                var footstr = "</body>";
                var newstr = document.all.item(printpage).innerHTML;
                var oldstr = document.body.innerHTML;
                document.body.innerHTML = headstr + newstr + footstr;
                window.print();
                document.body.innerHTML = oldstr;
                return false;
            }
        </script>
        <script>
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
     $('#mobiletable thead th').each(function(i) {
                calculateColumn(i);
            });
            function calculateColumn(index) {
            var total = 0;
            $('#mobiletable tr').each(function() {
                var value = parseInt($('th:visible', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#mobiletable tfoot td').eq(index).text(total);
        } 
  });
});
        </script>
        <script>
        $(document).ready(function() {
            $('#mobiletable thead th').each(function(i) {
                calculateColumn(i);
            });
    
        function calculateColumn(index) {
            var total = 0;
            $('#mobiletable tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#mobiletable tfoot td').eq(index).text(total);
        }
        });
    </script>           
        <script language="javascript">
                             var addSerialNumber = function () {
                                 var i = 0;
                                 $('#mobiletable tr').each(function (index) {
                                     $(this).find('td:nth-child(1)').html(index - 1 + 1);
                                 });
                             };

                             addSerialNumber();
        </script>
       
        <% } %>
    </body>
</html>
