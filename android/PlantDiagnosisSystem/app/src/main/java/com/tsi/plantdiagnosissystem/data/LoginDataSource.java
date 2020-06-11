package com.tsi.plantdiagnosissystem.data;

import com.tsi.plantdiagnosissystem.controller.UserController;
import com.tsi.plantdiagnosissystem.data.model.User;

import java.io.IOException;

/**
 * Class that handles authentication w/ login credentials and retrieves user information.
 */
public class LoginDataSource {

    public Result<User> login(String username, String password) {

        try {
            // TODO: handle loggedInUser authentication
//            User fakeUser =
//                    new User(
//                            java.util.UUID.randomUUID().toString(),
//                            "Jane Doe");
//            return new Result.Success<>(fakeUser);
            User loggedInUser = UserController.logInUser(username, password);
            if(loggedInUser != null) {
                return new Result.Success<>(loggedInUser);
            }else {
                return new Result.Error(new IOException("Invalid user email or password!"));
            }
        } catch (Exception e) {
            return new Result.Error(new IOException("Error logging in", e));
        }
    }

    public void logout() {
        // TODO: revoke authentication
    }
}
