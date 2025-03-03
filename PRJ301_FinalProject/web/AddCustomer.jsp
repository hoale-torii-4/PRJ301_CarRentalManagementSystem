<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Customer</title>
    </head>
    <body>
        <h1 >Add a new Customer</h1>

<form action="AddCustomer" method="post" accept-charset="UTF-8">
    <label>Enter Name:</label>
    <input type="text" name="name" required/><br/>

    <label>Enter Phone:</label>
    <input type="tel" name="phone" required pattern="[0-9+ -]{10,15}" title="Enter a valid phone number"/><br/>

    <label>Enter Sex:</label>
    <input type="radio" name="sex" value="M" required /> Male
    <input type="radio" name="sex" value="F" /> Female<br/>

    <label>Enter Address:</label>
    <input type="text" name="address" required/><br/>

    <input type="submit" value="Add"/>
</form>
    </body>
</html>
