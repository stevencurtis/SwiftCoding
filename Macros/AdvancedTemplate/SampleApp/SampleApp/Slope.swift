import WWDC

/// Slopes in my favorite ski resort.
enum Slope {
    case beginnersParadise
    case practiceRun
    case livingRoom
    case olympicRun
    case blackBeauty
}

/// Slopes suitable for beginners. Subset of `Slopes`.
@SlopeSubset
enum EasySlope {
    case beginnersParadise
    case practiceRun

    var slope: Slope {
        switch self {
        case .beginnersParadise: return .beginnersParadise
        case .practiceRun: return .practiceRun
        }
    }
}
