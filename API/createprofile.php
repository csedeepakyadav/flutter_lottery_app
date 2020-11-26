<?php
include ("db.php");

$email = $_POST['email'];

if (isset($email))
{

    $name = mysqli_real_escape_string($conn, $_POST['name']);

    $password = mysqli_real_escape_string($conn, $_POST['password']);


    $contact_no = mysqli_real_escape_string($conn, $_POST['contact_no']);

    $gender = mysqli_real_escape_string($conn, $_POST['gender']);

    $Date = mysqli_real_escape_string($conn, $_POST['date']);


    $checkemail = "SELECT * FROM `users` WHERE email = '$email'";

    $result = mysqli_query($conn, $checkemail);


    if ($result)
    {

        $rowcount = mysqli_num_rows($result);
        if ($rowcount == 0)
        {
               // checking if email already exists

            $sql = "INSERT INTO `users`(`name`, `email`, `password`, `contact_no`, `gender`,  `date`) VALUES ('$name', '$email', '$password', '$contact_no', '$gender', '$Date')";

            $inserteduser = mysqli_query($conn, $sql);



            if ($inserteduser)
            {


                $myObj->status = "updated";
                $myJSON = json_encode($myObj);
                echo $myJSON;

            }
            else
            {
                $myObj->status = "not updated";
                $myJSON = json_encode($myObj);
                echo $myJSON;
            }
        }
        else
        {
            $myObj->status = "exist";
            $myJSON = json_encode($myObj);
            echo $myJSON;
        }

    }
    else
    {
        $myObj->status = "not updated";
        $myJSON = json_encode($myObj);
        echo $myJSON;
    }

}
else
{
    $myObj->status = "not updated";
    $myJSON = json_encode($myObj);
    echo $myJSON;
}

?>
