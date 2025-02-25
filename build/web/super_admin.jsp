
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
        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link rel="icon" type="image/png" href="img/favicon.ico">
        <style>
            fieldset.scheduler-border {
                border: 1px groove black ;
                padding: 0 1.4em 1.4em 1.4em ;
                margin: 0 0 1.5em 0;
                -webkit-box-shadow:  0px 0px 0px 0px #000;
                box-shadow:  0px 0px 0px 0px #000;
            }

            legend.scheduler-border {
                width:inherit; 
                padding:0 10px; /* To give a bit of padding on the left and right */
                border-bottom:none;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div style=" margin-top: 10%" class="row">
            
            <div class="col-sm-3"></div>
            <div  class="col-sm-6">
                <fieldset class="scheduler-border">
                    <legend class="scheduler-border text-default" style="color: #030303"><strong>Super-Admin-Login</strong></legend>
                     <h4 style=" text-align: center; color: red"><strong>${error}</strong></h4>
                    <br><form action="SuperLoginServlet" method="POST" class="form-inline text-center" >
                        <div class="row">
                        <div class="input-group">
                            <span class="input-group-addon" style=" background-color: black; color: white" ><i class="glyphicon glyphicon-user"></i></span>
                            <input type="text" class="form-control"  style=" background-color: black; color: white" name="userid" value="" autocomplete="off" placeholder="User ID" autofocus="" required>
                        </div>
                        <br><br>
                        <div class="input-group">
                            <span class="input-group-addon" style=" background-color: black; color: white" ><i class="glyphicon glyphicon-lock"></i></span>
                            <input type="password" style=" background-color: black; color: white" class="form-control"   autocomplete="off" name="password" value="" placeholder="Password" required>
                        </div>
                        <br><br>
                       
                    <input type="submit" style="width: 150px ;border-top-left-radius: 30px; border-bottom-right-radius: 30px"  class="btn btn-success" value="LOG IN">
                      
                        </div>
                        <br><br>
                    </form>
                </fieldset>
                
            </div>


            <div class="col-sm-3"></div>
          
        </div>
    </div>
          <%@include file = "footerpage.jsp" %>          
    </body>
</html>
