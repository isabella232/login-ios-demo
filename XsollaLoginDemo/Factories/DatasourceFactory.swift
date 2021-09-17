// Copyright 2021-present Xsolla (USA), Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at q
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing and permissions and

// swiftlint:disable line_length
// swiftlint:disable type_name

import Foundation
import XsollaSDKLoginKit

protocol DatasourceFactoryProtocol
{
    func createUserAttributesListDataSource(params: UserAttributesListDataSourceFactoryParams) -> UserAttributesListDataSource
    func createConnectedDevicesListDataSource(params: ConnectedDevicesListDataSourceFactoryParams) -> ConnectedDevicesListDataSourceProtocol
}

class DatasourceFactory: DatasourceFactoryProtocol
{
    func createUserAttributesListDataSource(params: UserAttributesListDataSourceFactoryParams) -> UserAttributesListDataSource
    {
        switch params.type
        {
            case .custom: return CustomUserAttributesListDataSource(title: L10n.Character.TabBar.customAttributes,
                                                                    actionHandler: params.actionHandler)

            case .readonly: return ReadonlyUserAttributesListDataSource(title: L10n.Character.TabBar.readonlyAttributes,
                                                                        actionHandler: params.actionHandler)
        }
    }

    func createConnectedDevicesListDataSource(params: ConnectedDevicesListDataSourceFactoryParams) -> ConnectedDevicesListDataSourceProtocol
    {
        let titleAttrs = Style.heading2.attributes(withColor: .xsolla_white)
        let descAttrs = Style.description.attributes(withColor: .xsolla_inactiveWhite)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short

        let removable = params.removable

        let deviceItems = params.devices.map
        {
            ConnectedDevicesListItem(attributedTitle: $0.modelName.attributed(titleAttrs),
                                     attributedDescription: dateFormatter.string(from: $0.lastUsedAt).attributed(descAttrs),
                                     deviceId: String($0.xsollaDeviceId),
                                     removable: removable)
        }

        return ConnectedDevicesListDataSource(items: deviceItems)
    }
    
    // MARK: - Initialization
    
    let params: Params
    
    init(params: Params)
    {
        self.params = params
    }
}

extension DatasourceFactory
{
    typealias Params = EmptyParams
}

struct UserAttributesListDataSourceFactoryParams
{
    let type: AttributeType
    let actionHandler: UserAttributesListDataSource.ActionHandler

    enum AttributeType
    {
        case custom
        case readonly
    }

    static func custom(actionHandler: @escaping UserAttributesListDataSource.ActionHandler) -> Self
    {
        Self(type: .custom, actionHandler: actionHandler)
    }

    static func readonly(actionHandler: @escaping UserAttributesListDataSource.ActionHandler) -> Self
    {
        Self(type: .readonly, actionHandler: actionHandler)
    }
}

struct ConnectedDevicesListDataSourceFactoryParams
{
    let devices: [DeviceInfo]
    let removable: Bool
}
