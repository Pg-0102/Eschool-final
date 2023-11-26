<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <title>Teacher Dashboard - Upload Results</title>
    <link rel="stylesheet" type="text/css" href="assets/css/styles.css">
    <style>
        /* Add this CSS to style the "Insert New Result" section */
        .card-header {
            background-color: #007bff;
            color: #fff;
            font-weight: bold;
            padding: 10px;
            margin-bottom: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            font-weight: bold;
        }
        
        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        
        .col-md-4 {
            text-align: right;
            padding-right: 10px;
        }
        
        .col-md-6 {
            text-align: left;
        }
        
        .btn-primary {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        
        .btn-primary:hover {
            background-color: #0056b3;
        }
        
        .form-group.row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .form-group.row label {
            width: 40%; /* Adjust the width as needed */
            text-align: right;
            padding-right: 10px;
            font-weight: bold;
        }
        
        .form-group.row .col-md-6 {
            width: 60%; /* Adjust the width as needed */
        }
        
        .form-group.row .form-control {
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <div class="menu-toggle" id="menuToggle">
                <span class="bar"></span>
                <span class="bar"></span>
                <span class="bar"></span>
            </div>
           
        </div>
        <div class="content">
            <header>
                <h1>Teacher Dashboard - Upload Results</h1>
            </header>
            <div class="main-content">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">Insert New Result</div>
                        <div class="card-body">
                            <form action="resultUpdate.jsp" method="POST">
                                <div class="form-group row">
                                    <label for="rollNumber" class="col-md-4 col-form-label text-md-right">Roll Number</label>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" name="roll_number" required>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="enggPhysics" class="col-md-4 col-form-label text-md-right">Engg. Physics-I</label>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" name="engg_physics" required>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="enggChemistry" class="col-md-4 col-form-label text-md-right">Engg. Chemistry</label>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" name="engg_chemistry" required>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="enggMathematics" class="col-md-4 col-form-label text-md-right">Engg. Mathematics-I</label>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" name="engg_mathematics	" required>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="basicElectricalEngg" class="col-md-4 col-form-label text-md-right">Basic Electrical Engg</label>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" name="basic_electrical_engg" required>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="electronicEngg" class="col-md-4 col-form-label text-md-right">Electronic Engg.</label>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" name="electronic_engg" required>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="enggChemistryLab" class="col-md-4 col-form-label text-md-right">Engg. Chemistry Lab</label>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" name="engg_chemistry_lab" required>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="enggPhysicsLab" class="col-md-4 col-form-label text-md-right">Engg. Physics Lab</label>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" name="engg_physics_lab" required>
                                    </div>
                                </div>

                                <div class="col-md-6 offset-md-4">
                                    <button type="submit" class="btn btn-primary">Save</button>
                                </div>
                            </form>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
