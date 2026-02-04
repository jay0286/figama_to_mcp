import { useState } from 'react'
import FlutterAandIRenamed from './flutter_aandi_renamed'
import PluginTestingAutoName from './plugin_testing_autoname'
import PluginTestingLayerSense from './plugin_testing_layersense'
import { HomePage as HomeV1 } from './pages/home-v1'
import { HomePage as HomeV2 } from './pages/home-v2'

function App() {
  const [activeTab, setActiveTab] = useState(0)

  const tabs = [
    { name: '피그마 자체 리네임', component: FlutterAandIRenamed },
    { name: 'AI 플러그인 (A)', component: PluginTestingAutoName },
    { name: 'AI 플러그인 (B)', component: PluginTestingLayerSense },
    { name: '리팩토링 (V1)', component: HomeV1 },
    { name: '리팩토링 (V2)', component: HomeV2 },
  ]

  const ActiveComponent = tabs[activeTab].component

  return (
    <div className="min-h-screen bg-gray-900 flex flex-col items-center p-4">
      {/* Tab Navigation */}
      <div className="flex gap-2 mb-6">
        {tabs.map((tab, index) => (
          <button
            key={index}
            onClick={() => setActiveTab(index)}
            className={`px-4 py-2 rounded-lg font-medium transition-colors ${
              activeTab === index
                ? 'bg-orange-500 text-white'
                : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
            }`}
          >
            {tab.name}
          </button>
        ))}
      </div>

      {/* Phone Frame */}
      <div className="relative">
        <div className="w-[390px] h-[844px] bg-white rounded-[40px] overflow-hidden shadow-2xl border-[8px] border-gray-800">
          {/* Screen Content */}
          <div className="w-full h-full overflow-y-auto">
            <ActiveComponent />
          </div>
        </div>
      </div>

      {/* Info */}
      <div className="mt-4 text-gray-400 text-sm">
        현재 보기: {tabs[activeTab].name} (390x844)
      </div>
    </div>
  )
}

export default App
