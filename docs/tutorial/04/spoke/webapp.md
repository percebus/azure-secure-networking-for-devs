# Module 4: Create a Private WebApp in the Spoke VNet

## NOTE

## Resources

- [R]esource [G]roup (already exists): `{my-prefix}-spoke-{region}-{id}-rg`
  - [V]irtual [Net]work (already exists): `{my-prefix}-spoke-{region}-{id}-vnet`
   - [WebApp] resources: `{my-prefix}-spoke-{region}-{id}-webapp`
     - Service: `{my-prefix}-spoke-{region}-{id}-webapp-service`
      - [P]rivate [E]nd[p]oint: `{my-prefix}-spoke-{region}-{id}-webapp-pep`
         - [N]etwork [I]nterfa[c]e: `{my-prefix}-spoke-{region}-{id}-webapp-pep-nic`

Where:

- `{some-short-prefix}`: Your username (i.e. `johndoe`)
- `{region}`: The region of your Hub VNet (i.e. `wesutus2`)
- `{id}`: The unique identifier of the spoke VNet (i.e. `1`)

### WebApp

#### Market

Go to the Azure Portal and search for `WebApp` and click on `Create`.

![WebApp](../../../../assets/img/azure/market/webapp/logo.png)

#### Pricing

As of `2024-10-04`

![WebApp Pricing](../../../../assets/img/azure/market/webapp/pricing/2024-10-04T120811.png)

> [!Important]
> Free tier won't allow us to create Private Endpoints.

For this excercise, you will go w/ **Basic**

#### Create
