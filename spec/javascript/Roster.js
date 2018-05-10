import Roster from '../../app/javascript/components/Roster'
import Slot from '../../app/javascript/components/Slot'
import 'whatwg-fetch';

describe ('Roster', () => {
  let wrapper;

  beforeEach(() => {
    wrapper = mount(
      <Roster params={{ id: 1 }}/>
    )
  })

  it ("should have 3 headers and 3 lists", ()=>{
    expect(wrapper.find("h3").length).toEqual(3)
    expect(wrapper.find("ul").length).toEqual(3)
  })
  it ("renders roster slots", () => {
    expect(wrapper.find(Slot)).toBePresent()
  })
  it ("should have a starting roster", () => {
      expect(wrapper.find('#starters').text()).toContain("QB")
      expect(wrapper.find('#starters').text()).toContain("RB")
      expect(wrapper.find('#starters').text()).toContain("WR")
      expect(wrapper.find('#starters').text()).toContain("TE")
      expect(wrapper.find('#starters').text()).toContain("TE/WR/RB")
      expect(wrapper.find('#starters').text()).toContain("OT")
      expect(wrapper.find('#starters').text()).toContain("G")
      expect(wrapper.find('#starters').text()).toContain("C")
      expect(wrapper.find('#starters').text()).toContain("DT")
      expect(wrapper.find('#starters').text()).toContain("DE")
      expect(wrapper.find('#starters').text()).toContain("ILB")
      expect(wrapper.find('#starters').text()).toContain("OLB")
      expect(wrapper.find('#starters').text()).toContain("DT/LB")
      expect(wrapper.find('#starters').text()).toContain("CB")
      expect(wrapper.find('#starters').text()).toContain("SS")
      expect(wrapper.find('#starters').text()).toContain("FS")
      expect(wrapper.find('#starters').text()).toContain("CB/S")
      expect(wrapper.find('#starters').text()).toContain("P")
      expect(wrapper.find('#starters').text()).toContain("K")
      expect(wrapper.find('#starters').text()).toContain("Empty Roster Spot")
    })
  it ("should have a bench", () => {
      expect(wrapper.find('#bench')).toBePresent()
    })
  it ("should have a practice squad", () => {
      expect(wrapper.find('#ps')).toBePresent()
    })
})
