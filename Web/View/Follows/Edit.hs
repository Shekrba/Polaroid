module Web.View.Follows.Edit where
import Web.View.Prelude

data EditView = EditView { follow :: Follow }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={FollowsAction}>Follows</a></li>
                <li class="breadcrumb-item active">Edit Follow</li>
            </ol>
        </nav>
        <h1>Edit Follow</h1>
        {renderForm follow}
    |]

renderForm :: Follow -> Html
renderForm follow = formFor follow [hsx|
    {(textField #followerId)}
    {(textField #userId)}
    {submitButton}
|]
