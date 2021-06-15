module Web.View.Users.New where
import Web.View.Prelude
import Data.Maybe

data NewView = NewView { user :: User }

instance View NewView where
    html NewView { .. } = [hsx|
        <h1>New User</h1>
        {renderForm user}
    |]
       
renderForm :: User -> Html
renderForm user = formFor user [hsx|
    {(emailField #email)}
    {(passwordField #passwordHash) { fieldLabel = "Password" }}
    {(textField #firstName)}
    {(textField #lastName)}
    <div>
        <h5>
            Profile Image
        </h5>

        <div style="max-width: 300px">
            <div class="form-group">
                <label for="user_picture_url">
                    <img id="user_picture_url_preview" src="/images/user-placeholder.jpg" style="width: 12rem; min-height: 12rem; min-width: 12rem" class="mt-2 img-thumbnail text-center text-muted" alt="Image"/>
                    <input id="user_picture_url" type="file" name="pictureUrl" class="form-control form-control-file" style="display: none" data-preview="#user_picture_url_preview"/>
                    <div class="row ml-1 mt-2">
                         <label class="btn btn-dark" onclick="document.getElementById('user_picture_url_preview').click()">Upload</label>
                    </div>
                </label>
            </div>
        </div>
    </div>
    {submitButton}
|]
