<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Customer</title>
    </head>
    <body>
        <h1>Add a new Customer</h1>
        <form action="AddCustomer" method="post" accept-charset="UTF-8">
            Enter ID: <input type="text" name="id" required/><br/>
            Enter Name: <input type="text" name="name" required/><br/>
            Enter Phone: <input type="tel" name="phone" required pattern="[0-9+ -]{10,15}" title="Enter a valid phone number"/><br/>
            Enter Sex: 
            <input type="radio" name="sex" value="M" required /> Male
            <input type="radio" name="sex" value="F" /> Female<br/>
            Enter Address: <input type="text" name="address" required/><br/>
            <input type="submit" value="Add"/>
        </form>
    </body>
</html>
