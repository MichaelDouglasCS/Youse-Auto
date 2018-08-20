import UIKit

/**

A star rating view that can be used to show customer rating for the products. On can select stars by tapping on them when updateOnTouch settings is true. An optional text can be supplied that is shown on the right side.

Example:

    cosmosView.rating = 4
    cosmosView.text = "(123)"

Shows: ★★★★☆ (123)

*/
@IBDesignable open class CosmosView: UIView {
    
  /**
  
  The currently shown number of stars, usually between 1 and 5. If the value is decimal the stars will be shown according to the Fill Mode setting.

  */
  @IBInspectable open var rating: Double = CosmosDefaultSettings.rating {
    didSet {
      if oldValue != rating {
        update()
      }
    }
  }
  
  /// Star rating settings.
  open var settings: CosmosSettings = .default {
    didSet {
      update()
    }
  }
  
  /// Stores calculated size of the view. It is used as intrinsic content size.
  private var viewSize = CGSize()

  /// Draws the stars when the view comes out of storyboard with default settings
  open override func awakeFromNib() {
    super.awakeFromNib()
    
    update()
  }

  /**

  Initializes and returns a newly allocated cosmos view object.
  
  */
  public convenience init(settings: CosmosSettings = .default) {
    self.init(frame: .zero, settings: settings)
  }

  /**

  Initializes and returns a newly allocated cosmos view object with the specified frame rectangle.

  - parameter frame: The frame rectangle for the view.
  
  */
  override public convenience init(frame: CGRect) {
    self.init(frame: frame, settings: .default)
  }

  public init(frame: CGRect, settings: CosmosSettings) {
    super.init(frame: frame)
    self.settings = settings
    update()
    improvePerformance()
  }
  
  /// Initializes and returns a newly allocated cosmos view object.
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    improvePerformance()
  }
  
  /// Change view settings for faster drawing
  private func improvePerformance() {
    /// Cache the view into a bitmap instead of redrawing the stars each time
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale
    
    isOpaque = true
  }
  
  /**
  
  Updates the stars and optional text based on current values of `rating` and `text` properties.
  
  */
  open func update() {
    
    // Create star layers
    // ------------
    
    let layers = CosmosLayers.createStarLayers(
      rating,
      settings: settings,
      isRightToLeft: RightToLeft.isRightToLeft(self)
    )
    
    layer.sublayers = layers
    
    // Update size
    // ------------

    updateSize(layers)
  }
  
  /**

  Updates the size to fit all the layers containing stars and text.
  
  - parameter layers: Array of layers containing stars and the text.

  */
  private func updateSize(_ layers: [CALayer]) {
    viewSize = CosmosSize.calculateSizeToFitLayers(layers)
    invalidateIntrinsicContentSize()

    // Stretch the view to include all stars and the text.
    // Needed when used without Auto Layout to receive touches for all stars.
    frame.size = intrinsicContentSize
  }
  
  /// Returns the content size to fit all the star and text layers.
  override open var intrinsicContentSize: CGSize {
    return viewSize
  }
  
  // MARK: - Properties inspectable from the storyboard
  
  @IBInspectable var totalStars: Int = CosmosDefaultSettings.totalStars {
    didSet {
      settings.totalStars = totalStars
    }
  }
  
  @IBInspectable var starSize: Double = CosmosDefaultSettings.starSize {
    didSet {
      settings.starSize = starSize
    }
  }
  
  @IBInspectable var filledColor: UIColor = CosmosDefaultSettings.filledColor {
    didSet {
      settings.filledColor = filledColor
    }
  }
  
  @IBInspectable var emptyColor: UIColor = CosmosDefaultSettings.emptyColor {
    didSet {
      settings.emptyColor = emptyColor
    }
  }
    
  @IBInspectable var emptyBorderColor: UIColor = CosmosDefaultSettings.emptyBorderColor {
      didSet {
          settings.emptyBorderColor = emptyBorderColor
      }
  }
  
  @IBInspectable var emptyBorderWidth: Double = CosmosDefaultSettings.emptyBorderWidth {
      didSet {
          settings.emptyBorderWidth = emptyBorderWidth
      }
  }
  
  @IBInspectable var filledBorderColor: UIColor = CosmosDefaultSettings.filledBorderColor {
      didSet {
          settings.filledBorderColor = filledBorderColor
      }
  }
  
  @IBInspectable var filledBorderWidth: Double = CosmosDefaultSettings.filledBorderWidth {
      didSet {
          settings.filledBorderWidth = filledBorderWidth
      }
  }
  
  @IBInspectable var starMargin: Double = CosmosDefaultSettings.starMargin {
    didSet {
      settings.starMargin = starMargin
    }
  }
  
  @IBInspectable var fillMode: Int = CosmosDefaultSettings.fillMode.rawValue {
    didSet {
      settings.fillMode = StarFillMode(rawValue: fillMode) ?? CosmosDefaultSettings.fillMode
    }
  }
  
  @IBInspectable var updateOnTouch: Bool = CosmosDefaultSettings.updateOnTouch {
    didSet {
      settings.updateOnTouch = updateOnTouch
    }
  }
  
  @IBInspectable var minTouchRating: Double = CosmosDefaultSettings.minTouchRating {
    didSet {
      settings.minTouchRating = minTouchRating
    }
  }
  
  @IBInspectable var filledImage: UIImage? {
    didSet {
      settings.filledImage = filledImage
    }
  }
  
  @IBInspectable var emptyImage: UIImage? {
    didSet {
      settings.emptyImage = emptyImage
    }
  }
  
  /// Draw the stars in interface buidler
  open override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    
    update()
  }
}
