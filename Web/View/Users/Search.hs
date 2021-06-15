module Web.View.Users.Search where
import Web.View.Prelude
import Data.Maybe

data SearchView = SearchView { users :: [User] }

instance View SearchView where
    html SearchView { .. } = [hsx|
        <div class="row">
            <div class="col-3">
            </div>
            <div class="col">
                {forEach users renderUser}
            </div>
            <div class="col-3">
            </div>
        </div>
    |]

renderUser user = do [hsx|
            <a class="no-decoration" href={ShowUserAction (get #id user)}>
                <div class="card bg-dark text-light mb-3">
                    <div class="cart-body">
                        <div class="row p-2">
                            <div class="col-5">
                                <img class="medium-profile-image" src={fromJust(get #pictureUrl user)}/>
                            </div>
                            <div class="col pt-3">
                                <div class="row">
                                    <label class="bold">{get #firstName user <> " " <> get #lastName user}</label>
                                </div>
                                <div class="row">
                                    <label class="text-light">{get #email user}</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </a>
    |]
