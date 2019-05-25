# NAsyncLoader
 is a data download library for asynchronously download images and other data
 
 
 
## What does it support
  This library suport all data type and download it asynchronously and cache frequently used
  data
  
## How To Use
  The result of the request is represented by the type
  conforming to `NAsyncDataType` protocol.
  To ensure conformance the type must have an `init?(data: Data)` constructor.
  Conformance can easily be provided for types
  such as UIImage, XMLParser and PDFDocument by extensions as follows:

  ```
    extension UIImage: NAsyncDataType {}
    extension XMLParser: NAsyncDataType {}
    extension PDFDocument : NAsyncDataType {}
  ```

  To represent JSON resources the types `JSONObject<Type:BaseModel>` and `JSONArray<Type:BaseModel>`
  are defined below having a `value` property of type
  'Type and [Type] respectively.
## Example for UIImage
  
> you can clone and open PintrestImageLoader to see examples

  first you have to extends UIImage class with NAsyncDataType
  
  ```
    extension UIImage: NAsyncDataType {}
  ```
  Then you have to instantiate an object of the NAsyncURLLoader 
  it is a geniric class and can represent any data type
  
  ```
    let imageLoader = NAsyncURLLoader<UIImage>()
    
    imageLoader.requestResource(from: URL(string:url)!) { (result, _) in
            switch result{
            case .success(let image):
                imageView.image = image
                break
            case .empty:
                break
            case .error(let error):
                print("\(error)")
                break
            }
        }
  ```
  
## Example for JSONObject
  Here all you have to do is to instantiate an object of the NAsyncURLLoader< JsonObject >
  or NAsyncURLLoader< JSONObject< ModelType > >
   
> Model type is a model that conform to codeable protocol all you have to do is to extends your model class with 
  BaseMode
  
  ```
    class ModelExample:BaseModel{
      // attributes of your json
    }
    
       let jsonLoader = NAsyncURLLoader<JSONObject<ModelExample> > ()
     
        let url = "http://pastebin.com/raw/wgkJgazE"
        jsonLoader.requestResource(from: URL(string:url)!) { (result, _) in
            switch result{
            case .success(let response):
                // here the response.value is of type ModelExample
                break
            case .empty:
                break
            case .error(let error):
                print("1 \(error)")
                break
            }
        }
  ```
 
 and for JsonObject it will return a dictionary of [String: Any]
 
## Example for JSONArray 
 Same as before 
 for JsonArray you get [Any]
 and for JSONArray<ModelExample> you get a [ModelExample]
 
 
  ```
    class ModelExample:BaseModel{
      // attributes of your json
    }
    
       let jsonLoader = NAsyncURLLoader<JSONArray<ModelExample> > ()
     
        let url = "http://pastebin.com/raw/wgkJgazE"
        jsonLoader.requestResource(from: URL(string:url)!) { (result, _) in
            switch result{
            case .success(let response):
                // here the response.value is of type [ModelExample]
                break
            case .empty:
                break
            case .error(let error):
                print("1 \(error)")
                break
            }
        }
  ```
## Change Cache setting and session Settings
  ```
    // change Settings and cahce settings
        NAsyncSettings.settings.maximumSimultaneousDownloads = 4
        NAsyncSettings.settings.cache.memoryCapacityBytes    = 20 * 1024 * 1024
        NAsyncSettings.settings.cache.diskCapacityBytes      = 20 * 1024 * 1024
  ```
  
## How To install
  after you create a new project all you have to do is to Add the NAsyncLoader project tou your workspace 
  and import the NAsyncLoader.framework to Embedded Binaries


  <p><img src="/add.png" alt="Add NAsync to Project" title="title" /></p>
  
  <p><img src="/import.png" alt="Import NAsyncLoader.framework" title="title" /></p>
  
  
  
## About the pintrest Example
  this example shows how to use the library in collection view load 
  it use the library to load json and images and cahce it
  
  it use Pull to refresh
  size classes for fonts and constraints
  animation for showing the new cells on screen
  
  you can user paginate to load more data every time 
  
 ```
   // page size and index
    private var currentPage = 1
    private var pageSize = 10
 
 
     func fetchData(){
        let jsonLoader = NAsyncURLLoader<JSONArray<Response> > ()
        // use this url to test paginating
        let url = "https://picsum.photos/v2/list?page=\(currentPage)&limit=\(pageSize)"
        jsonLoader.requestResource(from: URL(string:url)!) { (result, _) in
            switch result{
            case .success(let response):
                self.items.append(contentsOf: response.value)
                self.itemsCount = self.items.count
                self.collectionView.reloadData()
                break
            case .empty:
                break
            case .error(let error):
                print("1 \(error)")
                break
            }
        }
        
    }
    
    func getNextPage(){
        // increse the page index and fetch the new data
        currentPage += 1
        fetchData()
    }
 
 // collectionview Delegate to triger the getNextPage() when reach the end of the list
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == itemsCount - 1{
            getNextPage()
        }
    }
 
 ```
