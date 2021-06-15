module Web.View.Follows.Index where
import Web.View.Prelude

data IndexView = IndexView { follows :: [Follow] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={FollowsAction}>Follows</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewFollowAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Follow</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach follows renderFollow}</tbody>
            </table>
        </div>
    |]


renderFollow :: Follow -> Html
renderFollow follow = [hsx|
    <tr>
        <td>{follow}</td>
        <td><a href={ShowFollowAction (get #id follow)}>Show</a></td>
        <td><a href={EditFollowAction (get #id follow)} class="text-muted">Edit</a></td>
        <td><a href={DeleteFollowAction (get #id follow)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
