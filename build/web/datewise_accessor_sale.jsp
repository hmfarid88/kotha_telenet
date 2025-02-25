
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DB.Ssymphonyy"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
            <center>
                <div class="panel panel-primary">
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
                                <li><a href="home.jsp" title="Mobile Hut"> <img src="img/logo.png" alt=""></a></li>
                                <li style="margin-left: 20px"><a href="home.jsp"><span class="fa fa-home"></span> Home</a></li>
                            </ul>
                           <ul class="nav navbar-nav navbar-right">
                               <li style=" margin: 15px 60px "><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li>
                                <li> <a href="#" name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>
                        </div>
                    </nav>
                    <div class="panel-body"> 

                        <div class="row">
                            <div class="col-sm-12">
                                <div id="div_print">
                                    <center>
                                        <h3>Date Wise Sale</h3>

                                        <h4>Date: ${param.date1} To ${param.date2} </h4>
                                        <hr>
                                        
                                        <h4>Accessories Sale List</h4>
                                        <table border="2" class="table-striped table-responsive" width="100%" id="actable" >
                                            <thead>
                                                <tr style=" background-color: black; color: white">
                                                    <th style="text-align: center">SN</th>
                                                    <th style="text-align: center">Invoice</th>
                                                    <th style="text-align: center">Customer</th>
                                                    <th style="text-align: center">Description</th>
                                                    <th style="text-align: center">Qty</th>
                                                    <th style="text-align: center">Sale Price</th>
                                                    <th style="text-align: center">Offer</th>
                                                    <th style="text-align: center">Nit Price</th>
                                                    <th style="text-align: center">Vendor</th>
                                                    <th style="text-align: center">Sale Date</th>
                                               </tr>
                                            </thead> 
                                            <tbody id="myTable">
                                                <%
                                                    String date1=request.getParameter("date1");
                                                    String date2=request.getParameter("date2");
                                                    Connection con = null;
                                                    PreparedStatement ps = null;
                                                    ResultSet rs=null;
                                                    ResultSet rs1=null;
                                                    try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select PRODUCT_NAME, PRODUCT_ID, MODEL, SELL_PRICE, DISCOUNT, DIS_NOTE, VENDOR, INVOICE_NO, CUSTOMER_ID, DATE from accessor_sale where DATE between '"+ date1 +"' and '"+ date2 +"' order by DATE ";
                                                        ps=con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                   int cid=rs.getInt(9);
                                                   String query1="select C_NAME, PHONE_NUMBER from customerinfo where CUSTOMER_ID="+cid;
                                                   ps=con.prepareStatement(query1);
                                                   rs1=ps.executeQuery();
                                                   while (rs1.next()) {
                                                %>
                                                <tr>
                                                    <td style="text-align: center"></td>
                                                    <td style="text-align: center"><%= rs.getString("INVOICE_NO")%></td>
                                                    <td style="text-align: center"><%= rs1.getString(1) %>, <%= rs1.getString(2) %></td>
                                                    <td style="text-align: center"><%= rs.getString("PRODUCT_NAME")%> <%= rs.getString("MODEL")%>, <%= rs.getString("PRODUCT_ID")%></td>
                                                    <th style="text-align: center">1</th>
                                                    <th style="text-align: center"><%= rs.getFloat("SELL_PRICE")%></th>
                                                    <th style="text-align: center"><%= rs.getFloat("DISCOUNT")%> (<%= rs.getString("DIS_NOTE")%>)</th>
                                                    <th style="text-align: center"><%= rs.getFloat("SELL_PRICE") - rs.getFloat("DISCOUNT") %></th>
                                                    <td style="text-align: center"><%= rs.getString("VENDOR")%></td>
                                                    <td style="text-align: center"><%= rs.getString("DATE")%></td>
                                                    
                                                </tr>

                                                <%
                                                       } }
                                                    } catch (Exception ex) {
                                                    }finally {
   try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }  
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                %>
                                            </tbody>
                                            <tfoot>
                                                <tr style="background-color: #CCCCCC">
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center">TOTAL</th>
                                                    <td style="text-align: center"></td>
                                                    <td style="text-align: center"></td>
                                                    <td style="text-align: center"></td>
                                                    <td style="text-align: center"></td>
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center"></th>
                                                </tr>
                                            </tfoot>
                                           
                                        </table>

                                    </center>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
            </center>
        
        </div>
    <%@include file = "footerpage.jsp" %> 
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery-3.1.1.min.js"></script>
                  
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
    $('table thead th').each(function(i) {
                calculateColumn(i);
            });
            function calculateColumn(index) {
            var total = 0;
            $('table tr').each(function() {
                var value = parseInt($('th:visible', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('table tfoot td').eq(index).text(total);
        } 
  });
});
</script>
     <script>
        $(document).ready(function() {
            $('table thead th').each(function(i) {
                calculateColumn(i);
            });
        });

        function calculateColumn(index) {
            var total = 0;
            $('table tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('table tfoot td').eq(index).text(total);
        }
    </script>                      
       
        <script language="javascript">
            var addSerialNumber = function () {
                var i = 0;
                $('#actable tr').each(function (index) {
                    $(this).find('td:nth-child(1)').html(index - 1 + 1);
                });
            };

            addSerialNumber();
        </script>

        <% } %>
    </body>
</html>
