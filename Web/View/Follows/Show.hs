module Web.View.Follows.Show where
import Web.View.Prelude

data ShowView = ShowView { follow :: Follow }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={FollowsAction}>Follows</a></li>
                <li class="breadcrumb-item active">Show Follow</li>
            </ol>
        </nav>
        <h1>Show Follow</h1>
        <p>{follow}</p>
    |]
