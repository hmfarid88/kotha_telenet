<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DB.Ssymphonyy"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Mobile Store</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
      <link rel="icon" type="image/png" sizes="32x32" href="img/favicon-32x32.png">
    </head>
    <body>
       <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
    <div class="container-fluid">
        <header>
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
                        <li><a href="home.jsp"><span class="fa fa-home"> Home</span></a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li style=" margin-right: 50px; margin-top: 15px "><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li>
                        <li><a href="dob_customer.jsp" > DOB Today</a></li>
                        <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                    </ul> 
                </div>
            </nav>
        </header>
        <div id="div_print">
            <div class="row">
                <div class="col-sm-12">
                    <center>
                        <h3 style="font-family: fontawesome"><b>Customer's Info</b></h3>
                        <h5><b>Date : <script> document.write(new Date().toLocaleDateString('en-GB'));</script> </b></h5>
                    </center>
                    <table border="2" width="100%" class="table-condensed table-responsive">
                        <thead>
                            <tr style="background-color: green; color: #ffffff">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Customer Name</th>
                                <th style="text-align: center">Qty</th>
                                <th style="text-align: center">Mobile Number</th>
                                <th style="text-align: center">Address</th>
                                <th style="text-align: center">DOB</th>
                                <th style="text-align: center">Sell Date</th>
                            </tr>
                        </thead>
                        <tbody id="myTable">
                            <%
                             Connection con = null;
                             PreparedStatement ps = null;  
                             ResultSet rs = null;
                             
                             try {
                             con = Ssymphonyy.getConnection();
                             String query = "select C_NAME, PHONE_NUMBER, ADDRESS, DOB, DATE from customerinfo";
                             ps = con.prepareStatement(query);
                             rs = ps.executeQuery();
                              while (rs.next()) {
                                  
                            %>
                            <tr style="background-color: #030303; color: #ffffff">
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= rs.getString("C_NAME") %></td>
                                <th style="text-align: center">1</th>
                                <td style="text-align: center"><%= rs.getString("PHONE_NUMBER") %></td>
                                <td style="text-align: center"><%= rs.getString("ADDRESS") %></td>
                                <td style="text-align: center"><%= rs.getString("DOB") %></td>
                                <td style="text-align: center"><%= rs.getString("DATE") %></td>
                            </tr>
                            <% }
                            
                                                            } catch (Exception ex) {
                                                            }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                            %>
                        </tbody>
                        <tfoot>
                            <tr style="background-color: green; color: #ffffff">
                                <th></th>
                                <th style="text-align: center">TOTAL</th>
                                <td style="text-align: center"></td>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th></th>
                            </tr>
                        </tfoot>
                    </table>

                </div>
            </div>
        </div>
    </div>
   
    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <script language="javascript">
                            var addSerialNumber = function () {
                                var i = 0;
                                $('table tr').each(function (index) {
                                    $(this).find('td:nth-child(1)').html(index - 1 + 1);
                                });
                            };

                            addSerialNumber();
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
  <% } %>
</body>
</html>
