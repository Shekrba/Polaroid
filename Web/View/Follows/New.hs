module Web.View.Follows.New where
import Web.View.Prelude

data NewView = NewView { follow :: Follow }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={FollowsAction}>Follows</a></li>
                <li class="breadcrumb-item active">New Follow</li>
            </ol>
        </nav>
        <h1>New Follow</h1>
        {renderForm follow}
    |]

renderForm :: Follow -> Html
renderForm follow = formFor follow [hsx|
    {(textField #followerId)}
    {(textField #userId)}
    {submitButton}
|]
