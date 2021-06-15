module Web.View.Posts.New where
import Web.View.Prelude

data NewView = NewView { post :: Post }

instance View NewView where
    html NewView { .. } = [hsx|
        <h1>New Post</h1>
        {renderForm post}
    |]

renderForm :: Post -> Html
renderForm post = formFor post [hsx|
    <div>
        <div style="max-width: 300px">
            <div class="form-group">
                <label for="user_picture_url">
                    <img id="user_picture_url_preview" src="images/placeholder.png" style="min-width: 1110px; max-width: 1110px" class="mt-2 img-thumbnail text-center center text-muted" alt="Image"/>
                    <input id="user_picture_url" type="file" name="pictureUrl" class="form-control form-control-file" style="display: none" data-preview="#user_picture_url_preview"/>
                </label>
            </div>
        </div>
    </div>
    {(textareaField #description)}
    {(hiddenField #userId)}
    {submitButton}
    <div class="mb-5"></div>
|]
