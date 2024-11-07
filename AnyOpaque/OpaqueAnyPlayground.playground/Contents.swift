import UIKit

protocol Band { }

protocol Instrument {
    func tune() -> String?
}

struct Drum: Instrument {
    func tune() -> String? {
        return "Tune the drum through banging it"
    }
}

struct Piano: Instrument {
    func tune() -> String? {
        return "Tune the Piano through specialist equipment"
    }
}

struct Detuned<T: Instrument>: Instrument {
    func tune() -> String? {
        return nil
    }
}

struct RockBand<T: Instrument, U: Instrument>: Band {
    func tune() -> String? {
        return "Play together"
    }
    
    let lead: T
    let rhythm: U
    init(lead: T, rhythm: U) {
        self.lead = lead
        self.rhythm = rhythm
    }
}

func makeBand() -> some Band {
    let lead = Piano()
    let rhythm = Drum()
    let band = RockBand(lead: lead, rhythm: rhythm)
    return band
}

let myBand: some Band = makeBand()
